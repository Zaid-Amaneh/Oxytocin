import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geolocator/geolocator.dart' as geolocator;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:logger/logger.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:oxytocin/core/Utils/app_styles.dart';
import 'package:oxytocin/core/Utils/helpers/helper.dart';
import 'package:oxytocin/core/theme/app_colors.dart';
import 'package:toastification/toastification.dart';

class ClinicLocationPage extends StatefulWidget {
  final double clinicLatitude;
  final double clinicLongitude;
  final String clinicName;
  final String clinicLocation;
  final String clinicPhone;

  const ClinicLocationPage({
    super.key,
    required this.clinicLatitude,
    required this.clinicLongitude,
    required this.clinicName,
    required this.clinicLocation,
    required this.clinicPhone,
  });

  @override
  State<ClinicLocationPage> createState() => _ClinicLocationPageState();
}

class _ClinicLocationPageState extends State<ClinicLocationPage> {
  static const String _markerId = 'clinic_location';
  static const String _userMarkerId = 'user_location';
  static const String _polylineId = 'route';

  final String? _apiKey = dotenv.env['GOOGLE_MAPS_API_KEY'];
  GoogleMapController? _mapController;
  final Set<Marker> _markers = {};
  final Set<Polyline> _polylines = {};
  bool _isLoadingRoute = false;
  late TapGestureRecognizer _tapRecognizer;
  bool _isInitialized = false;
  final Logger _logger = Logger();

  geolocator.Position? _cachedUserPosition;
  DateTime? _lastLocationUpdate;
  static const Duration _locationCacheTimeout = Duration(minutes: 5);

  @override
  void initState() {
    super.initState();
    _validateApiKey();
    _initializeTapRecognizer();
  }

  void _validateApiKey() {
    if (_apiKey == null || _apiKey.isEmpty) {
      _logger.e('Google Maps API key is missing or empty');
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          Helper.customToastification(
            context: context,
            type: ToastificationType.error,
            title: context.tr.error,
            description: context.tr.apiKeyError,
            seconds: 5,
          );
        }
      });
    }
  }

  void _initializeTapRecognizer() {
    _tapRecognizer = TapGestureRecognizer()
      ..onTap = () {
        if (!_isLoadingRoute) {
          _drawRoute();
        }
      };
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInitialized) {
      _addClinicMarker();
      _isInitialized = true;
    }
  }

  @override
  void dispose() {
    _tapRecognizer.dispose();
    _mapController?.dispose();
    super.dispose();
  }

  void _addClinicMarker() {
    final clinicMarker = Marker(
      markerId: const MarkerId(_markerId),
      position: LatLng(widget.clinicLatitude, widget.clinicLongitude),
      infoWindow: InfoWindow(
        title: '${context.tr.d}.${widget.clinicName}',
        snippet: widget.clinicPhone,
      ),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
    );

    setState(() {
      _markers.add(clinicMarker);
    });
  }

  Future<void> _drawRoute() async {
    if (_apiKey == null || _apiKey.isEmpty) {
      _showError(context.tr.apiKeyError);
      return;
    }

    setState(() {
      _isLoadingRoute = true;
      _polylines.clear();
      _markers.removeWhere((m) => m.markerId.value == _userMarkerId);
    });

    try {
      final userPosition = await _getUserCurrentLocation();
      if (userPosition == null) {
        _logger.w('Could not get user location');
        if (mounted) {
          _showError(context.tr.locationError);
        }
        return;
      }

      if (mounted) {
        _addUserLocationMarker(userPosition);
      }

      final polylinePoints = await _getPolylinePoints(userPosition);
      if (polylinePoints.isEmpty) {
        _logger.w('No route found');
        if (mounted) {
          _showError(context.tr.routeNotFound);
        }
        return;
      }

      if (mounted) {
        _addRoutePolyline(polylinePoints);
        _animateCameraToBounds(userPosition);
      }
    } catch (e) {
      _logger.e('Error drawing route: $e');
      if (mounted) {
        String errorMessage = context.tr.routeError;
        if (e.toString().contains('NO_ROUTE_FOUND')) {
          errorMessage = context.tr.noRouteFound;
        } else if (e.toString().contains('API_KEY_ERROR')) {
          errorMessage = context.tr.apiKeyError;
        } else if (e.toString().contains('QUOTA_EXCEEDED')) {
          errorMessage = context.tr.quotaExceeded;
        } else if (e.toString().contains('timeout')) {
          errorMessage = context.tr.error;
        }

        _showError(errorMessage);
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoadingRoute = false;
        });
      }
    }
  }

  void _addUserLocationMarker(geolocator.Position userPosition) {
    final userMarker = Marker(
      markerId: const MarkerId(_userMarkerId),
      position: LatLng(userPosition.latitude, userPosition.longitude),
      infoWindow: InfoWindow(title: context.tr.yourLocation),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
    );

    setState(() {
      _markers.add(userMarker);
    });
  }

  void _addRoutePolyline(List<LatLng> points) {
    final polyline = Polyline(
      polylineId: const PolylineId(_polylineId),
      color: Theme.of(context).primaryColor,
      width: 5,
      points: points,
    );

    setState(() {
      _polylines.add(polyline);
    });
  }

  void _showError(String message) {
    Helper.customToastification(
      context: context,
      type: ToastificationType.error,
      title: context.tr.error,
      description: message,
      seconds: 5,
    );
  }

  bool _shouldUpdateLocation() {
    return _cachedUserPosition == null ||
        _lastLocationUpdate == null ||
        DateTime.now().difference(_lastLocationUpdate!) > _locationCacheTimeout;
  }

  Future<geolocator.Position?> _getUserCurrentLocation() async {
    if (!_shouldUpdateLocation()) {
      return _cachedUserPosition;
    }

    try {
      bool serviceEnabled =
          await geolocator.Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        final locationService = Location();
        try {
          serviceEnabled = await locationService.requestService();
        } catch (e) {
          _logger.e('Error requesting location service: $e');
        }

        if (!serviceEnabled) {
          if (mounted) {
            Helper.customToastification(
              context: context,
              type: ToastificationType.info,
              title: context.tr.permissions_error_title,
              description: context.tr.location_services_disabled,
              seconds: 5,
            );
          }
          return null;
        }
      }

      geolocator.LocationPermission permission =
          await geolocator.Geolocator.checkPermission();

      if (permission == geolocator.LocationPermission.denied) {
        permission = await geolocator.Geolocator.requestPermission();

        if (permission == geolocator.LocationPermission.denied) {
          if (mounted) {
            Helper.customToastification(
              context: context,
              type: ToastificationType.warning,
              title: context.tr.permissions_error_title,
              description: context.tr.location_permission_denied,
              seconds: 5,
            );
          }
          return null;
        }
      }

      if (permission == geolocator.LocationPermission.deniedForever) {
        if (mounted) {
          Helper.customToastification(
            context: context,
            type: ToastificationType.error,
            title: context.tr.permissions_error_title,
            description: context.tr.location_permission_denied_forever,
            seconds: 5,
          );
        }
        return null;
      }

      final geolocator.LocationSettings locationSettings =
          const geolocator.LocationSettings(
            accuracy: geolocator.LocationAccuracy.high,
            distanceFilter: 10,
            timeLimit: Duration(seconds: 15),
          );

      final position = await geolocator.Geolocator.getCurrentPosition(
        locationSettings: locationSettings,
      );

      _cachedUserPosition = position;
      _lastLocationUpdate = DateTime.now();

      return position;
    } catch (e) {
      _logger.e('Error getting user location: $e');

      if (mounted) {
        String errorMessage = context.tr.locationError;
        if (e.toString().contains('TIMEOUT') ||
            e.toString().contains('timeout')) {
          errorMessage = context.tr.locationTimeout;
        }

        Helper.customToastification(
          context: context,
          type: ToastificationType.error,
          title: context.tr.permissions_error_title,
          description: errorMessage,
          seconds: 5,
        );
      }
      return null;
    }
  }

  Future<List<LatLng>> _getPolylinePoints(
    geolocator.Position startPosition,
  ) async {
    if (_apiKey == null || _apiKey.isEmpty) {
      throw Exception('API key is not available');
    }

    final List<LatLng> polylineCoordinates = [];

    try {
      final uri =
          Uri.https('maps.googleapis.com', '/maps/api/directions/json', {
            'origin': '${startPosition.latitude},${startPosition.longitude}',
            'destination': '${widget.clinicLatitude},${widget.clinicLongitude}',
            'key': _apiKey,
            'mode': 'driving',
            'language': Localizations.localeOf(context).languageCode,
          });

      final response = await http
          .get(uri)
          .timeout(
            const Duration(seconds: 10),
            onTimeout: () => throw Exception('Request timeout'),
          );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['status'] == 'OK' && data['routes'].isNotEmpty) {
          final encodedPoints =
              data['routes'][0]['overview_polyline']['points'];
          final decodedPoints = PolylinePoints.decodePolyline(encodedPoints);

          for (var point in decodedPoints) {
            polylineCoordinates.add(LatLng(point.latitude, point.longitude));
          }
        } else {
          final status = data['status'] ?? 'UNKNOWN_ERROR';
          _logger.e('Google Maps API error: $status');

          String errorCode = 'ROUTE_ERROR';
          switch (status) {
            case 'ZERO_RESULTS':
              errorCode = 'NO_ROUTE_FOUND';
              break;
            case 'REQUEST_DENIED':
              errorCode = 'API_KEY_ERROR';
              break;
            case 'OVER_QUERY_LIMIT':
              errorCode = 'QUOTA_EXCEEDED';
              break;
          }
          throw Exception(errorCode);
        }
      } else {
        _logger.e('HTTP Error: ${response.statusCode} - ${response.body}');
        throw Exception('HTTP ${response.statusCode}');
      }
    } catch (e) {
      _logger.e('Error fetching directions: $e');
      rethrow;
    }

    return polylineCoordinates;
  }

  void _animateCameraToBounds(geolocator.Position userPosition) {
    if (_mapController == null) return;

    try {
      final start = LatLng(userPosition.latitude, userPosition.longitude);
      final end = LatLng(widget.clinicLatitude, widget.clinicLongitude);

      final double minLat = [
        start.latitude,
        end.latitude,
      ].reduce((a, b) => a < b ? a : b);
      final double maxLat = [
        start.latitude,
        end.latitude,
      ].reduce((a, b) => a > b ? a : b);
      final double minLng = [
        start.longitude,
        end.longitude,
      ].reduce((a, b) => a < b ? a : b);
      final double maxLng = [
        start.longitude,
        end.longitude,
      ].reduce((a, b) => a > b ? a : b);

      final bounds = LatLngBounds(
        southwest: LatLng(minLat, minLng),
        northeast: LatLng(maxLat, maxLng),
      );

      _mapController!.animateCamera(
        CameraUpdate.newLatLngBounds(bounds, 120.0),
      );
    } catch (e) {
      _logger.e('Error animating camera: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.all(screenWidth * 0.04),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            context.tr.clinicLocation,
            style: AppStyles.almaraiBold(
              context,
            ).copyWith(color: AppColors.textPrimary, fontSize: 18),
          ),
          SizedBox(height: screenHeight * 0.02),
          Container(
            height: screenHeight * 0.45,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  spreadRadius: 2,
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: LatLng(
                        widget.clinicLatitude,
                        widget.clinicLongitude,
                      ),
                      zoom: 15.0,
                    ),
                    markers: _markers,
                    polylines: _polylines,
                    onMapCreated: (GoogleMapController controller) {
                      _mapController = controller;
                    },
                    mapType: MapType.normal,
                    myLocationEnabled: false,
                    myLocationButtonEnabled: false,
                    zoomControlsEnabled: true,
                    mapToolbarEnabled: true,
                    compassEnabled: true,
                    rotateGesturesEnabled: true,
                    scrollGesturesEnabled: true,
                    tiltGesturesEnabled: true,
                    zoomGesturesEnabled: true,
                    gestureRecognizers: {
                      Factory<OneSequenceGestureRecognizer>(
                        () => EagerGestureRecognizer(),
                      ),
                    },
                  ),
                  if (_isLoadingRoute)
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.9),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Theme.of(context).primaryColor,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            context.tr.loadingRoute,
                            style: AppStyles.almaraiBold(context).copyWith(
                              color: AppColors.textPrimary,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
          SizedBox(height: screenHeight * 0.02),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.kPrimaryColor4.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: AppColors.kPrimaryColor4.withValues(alpha: 0.3),
                width: 1,
              ),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.location_on,
                  color: AppColors.kPrimaryColor1,
                  size: 16,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    widget.clinicLocation,
                    style: AppStyles.almaraiBold(
                      context,
                    ).copyWith(color: AppColors.textSecondary, fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: screenHeight * 0.02),
          Center(
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: AppStyles.almaraiBold(
                  context,
                ).copyWith(color: AppColors.textPrimary, fontSize: 14),
                children: [
                  TextSpan(text: context.tr.easilyLocateClinic),
                  const TextSpan(text: ' '),
                  TextSpan(
                    text: context.tr.oneClick,
                    style: TextStyle(
                      color: _isLoadingRoute
                          ? Colors.grey
                          : Theme.of(context).primaryColor,
                      fontWeight: FontWeight.w900,
                      decoration: TextDecoration.underline,
                      decorationColor: _isLoadingRoute
                          ? Colors.grey
                          : Theme.of(context).primaryColor,
                      decorationThickness: 2,
                    ),
                    recognizer: _isLoadingRoute ? null : _tapRecognizer,
                  ),
                  if (_isLoadingRoute) ...[const TextSpan(text: '...')],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
