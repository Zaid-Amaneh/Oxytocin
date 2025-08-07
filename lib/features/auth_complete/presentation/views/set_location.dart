import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:oxytocin/core/routing/route_names.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oxytocin/features/auth_complete/presentation/cubit/profile_info_cubit.dart';
import 'package:oxytocin/features/auth_complete/presentation/widget/profile_action_button.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class SetLocation extends StatefulWidget {
  const SetLocation({super.key});

  @override
  State<SetLocation> createState() => _SetLocationState();
}

class _SetLocationState extends State<SetLocation> {
  final TextEditingController _locationController = TextEditingController();
  String _locationName = "";
  double? _latitude;
  double? _longitude;
  GoogleMapController? _mapController;
  LatLng? _selectedLatLng;

  @override
  void dispose() {
    _locationController.dispose();
    super.dispose();
  }

  Future<void> _getCurrentLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('يرجى تفعيل خدمة الموقع')));
        await Geolocator.openLocationSettings();
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('تم رفض إذن الموقع')));
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('تم رفض إذن الموقع بشكل دائم')),
        );
        return;
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      setState(() {
        _selectedLatLng = LatLng(position.latitude, position.longitude);
        _latitude = position.latitude;
        _longitude = position.longitude;
      });

      _mapController?.animateCamera(CameraUpdate.newLatLng(_selectedLatLng!));
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('خطأ في الحصول على الموقع: $e')));
    }
  }

  void sendLocation() async {
    if (_locationName.isEmpty || _latitude == null || _longitude == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('يرجى إدخال الموقع وتحديده على الخريطة')),
      );
      return;
    }
    context.read<ProfileInfoCubit>().setLocation(_locationName);
    context.read<ProfileInfoCubit>().setLatitude(_latitude.toString());
    context.read<ProfileInfoCubit>().setLongitude(_longitude.toString());

    await context.read<ProfileInfoCubit>().submitMedicalInfo();
    context.read<ProfileInfoCubit>();

    final state = context.read<ProfileInfoCubit>().state;
    if (state.isSuccess) {
      context.pushNamed(RouteNames.upload);
    } else if (state.errorMessage != null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 40),

              const Text(
                "لنكن أقرب إليك  \n أدخل موقعك وحدده على الخريطة ",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  color: Color(0xFF1A237E),
                  fontWeight: FontWeight.bold,
                  fontFamily: 'AlmaraiRegular',
                ),
              ),
              const SizedBox(height: 32),

              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(26),
                  border: Border.all(color: const Color(0xFFE0E0E0)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 5,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: TextField(
                  controller: _locationController,
                  readOnly: false,
                  onChanged: (value) {
                    setState(() {
                      _locationName = value;
                    });
                  },
                  decoration: const InputDecoration(
                    suffixIcon: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.location_on_outlined,
                        color: Color(0xFF64B5F6),
                      ),
                    ),
                    hintText: "موقعك الحالي",
                    hintStyle: TextStyle(
                      color: Color(0xFF424242),
                      fontWeight: FontWeight.bold,
                      fontFamily: 'AlmaraiRegular',
                      fontSize: 14,
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 16,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                "اكتب عنوانك أو اسم منطقتك (مثال: شارع بغداد).",
                style: TextStyle(
                  fontSize: 10,
                  color: Color(0xFF9E9E9E),
                  fontFamily: 'AlmaraiRegular',
                ),
              ),
              const SizedBox(height: 32),
              const Text(
                "حرك الخريطة أو استخدم الموقع الحالي لتحديد موقعك بدقة",
                style: TextStyle(
                  fontSize: 18,
                  color: Color(0xFF424242),
                  fontWeight: FontWeight.bold,
                  fontFamily: 'AlmaraiRegular',
                ),
              ),
              const SizedBox(height: 16),
              Container(
                height: 180,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFE0E0E0)),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Stack(
                    children: [
                      GoogleMap(
                        initialCameraPosition: CameraPosition(
                          target:
                              _selectedLatLng ?? const LatLng(33.5138, 36.2765),
                          zoom: 14,
                        ),
                        onMapCreated: (controller) {
                          setState(() {
                            _mapController = controller;
                          });
                          // تأخير قليل قبل الحصول على الموقع
                          Future.delayed(
                            const Duration(milliseconds: 1000),
                            () {
                              if (mounted) {
                                _getCurrentLocation();
                              }
                            },
                          );
                        },
                        onCameraMove: (CameraPosition position) {
                          setState(() {
                            _selectedLatLng = position.target;
                            _latitude = position.target.latitude;
                            _longitude = position.target.longitude;
                          });
                        },
                        myLocationEnabled: true,
                        myLocationButtonEnabled: false,
                        zoomControlsEnabled: false,
                        mapToolbarEnabled: false,
                        compassEnabled: true,
                        markers: _selectedLatLng != null
                            ? {
                                Marker(
                                  markerId: const MarkerId("selected-location"),
                                  position: _selectedLatLng!,
                                  icon: BitmapDescriptor.defaultMarkerWithHue(
                                    BitmapDescriptor.hueBlue,
                                  ),
                                ),
                              }
                            : {},
                      ),
                      Positioned(
                        bottom: 16,
                        right: 16,
                        child: FloatingActionButton(
                          mini: true,
                          backgroundColor: Colors.white,
                          onPressed: _getCurrentLocation,
                          child: const Icon(
                            Icons.my_location,
                            color: Color(0xFF1A237E),
                          ),
                        ),
                      ),
                      // مؤشر تحميل في حالة عدم ظهور الخريطة
                      if (_mapController == null)
                        Positioned.fill(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: const Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircularProgressIndicator(
                                    color: Color(0xFF1A237E),
                                  ),
                                  SizedBox(height: 16),
                                  Text(
                                    'جاري تحميل الخريطة...',
                                    style: TextStyle(
                                      color: Color(0xFF1A237E),
                                      fontFamily: 'AlmaraiRegular',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),

              const Spacer(),

              Row(
                children: [
                  Expanded(
                    child: ProfileActionButton(
                      text: "ابدأ الآن",
                      onPressed: sendLocation,
                      filled: true,
                      borderRadius: 20,
                      fontSize: 16,
                      color: const Color(0xFF000957),
                      height: 56,
                    ),
                  ),

                  const SizedBox(width: 16),
                  Expanded(
                    child: ProfileActionButton(
                      text: "عودة",
                      onPressed: () {
                        context.pop();
                      },
                      filled: true,
                      borderRadius: 20,
                      fontSize: 16,
                      color: const Color(0xFF000957),
                      height: 56,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
