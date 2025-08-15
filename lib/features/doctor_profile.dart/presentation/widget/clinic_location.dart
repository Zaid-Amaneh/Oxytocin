import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geolocator/geolocator.dart';
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

  const ClinicLocationPage({
    super.key,
    required this.clinicLatitude,
    required this.clinicLongitude,
    required this.clinicName,
    required this.clinicLocation,
  });

  @override
  State<ClinicLocationPage> createState() => _ClinicLocationPageState();
}

class _ClinicLocationPageState extends State<ClinicLocationPage> {
  final String _apiKey = dotenv.env['GOOGLE_MAPS_API_KEY'] ?? '';
  GoogleMapController? mapController;
  final Set<Marker> _markers = {};
  final Set<Polyline> _polylines = {};
  bool _isLoadingRoute = false;
  late TapGestureRecognizer _tapRecognizer;
  bool isInit = true;
  @override
  void initState() {
    super.initState();
    _tapRecognizer = TapGestureRecognizer()
      ..onTap = () {
        _drawRoute();
      };
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (isInit) {
      _addClinicMarker();
      isInit = false;
    }
  }

  @override
  void dispose() {
    _tapRecognizer.dispose();
    mapController?.dispose();
    super.dispose();
  }

  void _addClinicMarker() {
    _markers.add(
      Marker(
        markerId: const MarkerId('clinic_location'),
        position: LatLng(widget.clinicLatitude, widget.clinicLongitude),
        infoWindow: InfoWindow(
          title: '${context.tr.d}.${widget.clinicName}',
          snippet: context.tr.clinicLocation,
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      ),
    );
  }

  Future<void> _drawRoute() async {
    setState(() {
      _isLoadingRoute = true;
      _polylines.clear();
      _markers.removeWhere((m) => m.markerId.value == 'user_location');
    });

    try {
      final userPosition = await _getUserCurrentLocation(context);
      if (userPosition == null) {
        Logger().w('Could not get user location.');
        return;
      }
      _markers.add(
        Marker(
          markerId: const MarkerId('user_location'),
          position: LatLng(userPosition.latitude, userPosition.longitude),
          infoWindow: const InfoWindow(title: 'Your Location'),
          icon: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueGreen,
          ),
        ),
      );
      final polylinePoints = await _getPolylinePoints(userPosition);
      if (polylinePoints.isEmpty) {
        Logger().w('No route found.');
        return;
      }
      _polylines.add(
        Polyline(
          polylineId: const PolylineId('route'),
          color: Colors.blue,
          width: 5,
          points: polylinePoints,
        ),
      );
      _animateCameraToBounds(userPosition);
    } catch (e) {
      Logger().e('Error drawing route: $e');
    } finally {
      if (mounted) {
        setState(() {
          _isLoadingRoute = false;
        });
      }
    }
  }

  Future<Position?> _getUserCurrentLocation(BuildContext context) async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Location location = Location();
      await location.requestService();
      serviceEnabled = await location.serviceEnabled();

      if (context.mounted && !serviceEnabled) {
        Helper.customToastification(
          context: context,
          type: ToastificationType.info,
          title: context.tr.permissions_error_title,
          description: context.tr.location_services_disabled,
          seconds: 5,
        );
      }
      if (!serviceEnabled) {
        return null;
      }
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      while (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
    }

    if (permission == LocationPermission.deniedForever) {
      if (context.mounted) {
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

    return await Geolocator.getCurrentPosition();
  }

  Future<List<LatLng>> _getPolylinePoints(Position startPosition) async {
    final List<LatLng> polylineCoordinates = [];
    final Uri uri = Uri.parse(
      'https://maps.googleapis.com/maps/api/directions/json?origin=${startPosition.latitude},${startPosition.longitude}&destination=${widget.clinicLatitude},${widget.clinicLongitude}&key=$_apiKey',
    );

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['routes'].isNotEmpty) {
        final result = PolylinePoints.decodePolyline(
          data['routes'][0]['overview_polyline']['points'],
        );
        for (var point in result) {
          polylineCoordinates.add(LatLng(point.latitude, point.longitude));
        }
      }
    } else {
      Logger().e('Failed to fetch directions: ${response.body}');
    }
    return polylineCoordinates;
  }

  void _animateCameraToBounds(Position userPosition) {
    if (mapController == null) return;

    final LatLng start = LatLng(userPosition.latitude, userPosition.longitude);
    final LatLng end = LatLng(widget.clinicLatitude, widget.clinicLongitude);

    final LatLngBounds bounds = LatLngBounds(
      southwest: LatLng(
        start.latitude < end.latitude ? start.latitude : end.latitude,
        start.longitude < end.longitude ? start.longitude : end.longitude,
      ),
      northeast: LatLng(
        start.latitude > end.latitude ? start.latitude : end.latitude,
        start.longitude > end.longitude ? start.longitude : end.longitude,
      ),
    );

    mapController!.animateCamera(CameraUpdate.newLatLngBounds(bounds, 100.0));
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
            ).copyWith(color: AppColors.textPrimary),
          ),
          SizedBox(height: screenHeight * 0.02),
          Container(
            height: screenHeight * 0.45,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  spreadRadius: 2,
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
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
                      mapController = controller;
                    },
                    mapType: MapType.normal,
                    myLocationEnabled: false,
                    myLocationButtonEnabled: false,
                    zoomControlsEnabled: true,
                    mapToolbarEnabled: true,
                    gestureRecognizers: {
                      Factory<OneSequenceGestureRecognizer>(
                        () => EagerGestureRecognizer(),
                      ),
                    },
                  ),
                  if (_isLoadingRoute) const CircularProgressIndicator(),
                ],
              ),
            ),
          ),
          SizedBox(height: screenHeight * 0.02),
          Text(
            widget.clinicLocation,
            style: AppStyles.almaraiBold(
              context,
            ).copyWith(color: AppColors.textSecondary, fontSize: 12),
          ),
          SizedBox(height: screenHeight * 0.02),
          RichText(
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
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                    decorationColor: Theme.of(context).primaryColor,
                  ),
                  recognizer: _tapRecognizer,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
