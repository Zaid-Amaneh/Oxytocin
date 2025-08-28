import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:oxytocin/core/constants/api_endpoints.dart';
import 'package:oxytocin/core/routing/navigation_service.dart';
import 'package:oxytocin/core/routing/route_names.dart';
import 'package:oxytocin/features/home/data/model/doctor_model.dart';
import 'package:oxytocin/features/home/data/model/nearby_doctor_model.dart';
import 'package:oxytocin/features/home/data/services/doctors_service.dart';
import 'package:oxytocin/core/Utils/services/location_service.dart';
import 'package:oxytocin/features/favorites/data/services/favorite_manager.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final DoctorsService _doctorsService;
  final FavoriteManager _favoriteManager = FavoriteManager();

  List<DoctorModel> _doctors = [];
  List<NearbyDoctorModel> _nearbyDoctors = [];
  bool _isLoadingDoctors = false;
  bool _isLoadingNearbyDoctors = false;
  List<DoctorInfo> doctorInfo = [];

  HomeCubit()
    : _doctorsService = DoctorsService(baseUrl: ApiEndpoints.baseURL),
      super(HomeInitial()) {
    _initializeFavoriteManager();
  }

  Future<void> _initializeFavoriteManager() async {
    try {
      await _favoriteManager.initialize();
    } catch (e) {}
  }

  List<DoctorModel> get doctors => _doctors;
  List<NearbyDoctorModel> get nearbyDoctors => _nearbyDoctors;
  bool get isLoadingDoctors => _isLoadingDoctors;
  bool get isLoadingNearbyDoctors => _isLoadingNearbyDoctors;
  bool isDoctorFavorite(int doctorId) {
    return _favoriteManager.isFavorite(doctorId);
  }

  void refreshFavoriteState() {
    emit(HomeFullyLoaded(doctors: _doctors, nearbyDoctors: _nearbyDoctors));
  }

  void loadDoctors(double latitude, double longitude) async {
    try {
      _isLoadingDoctors = true;
      if (_nearbyDoctors.isEmpty) {
        emit(HomeLoading());
      }
      final doctors = await _doctorsService.getHighestRatedDoctors(
        latitude: latitude,
        longitude: longitude,
      );
      _doctors = doctors;
      _isLoadingDoctors = false;
      if (_nearbyDoctors.isNotEmpty) {
        emit(HomeFullyLoaded(doctors: _doctors, nearbyDoctors: _nearbyDoctors));
      } else {
        emit(HomeLoaded(_doctors));
      }
    } catch (e) {
      _isLoadingDoctors = false;
      emit(HomeError(e.toString()));
    }
  }

  void loadNearbyDoctors(double latitude, double longitude) async {
    try {
      _isLoadingNearbyDoctors = true;
      if (_doctors.isEmpty) {
        emit(HomeLoading());
      }

      final nearbyDoctors = await _doctorsService.getNearbyDoctors(
        latitude: latitude,
        longitude: longitude,
      );

      _nearbyDoctors = nearbyDoctors;
      _isLoadingNearbyDoctors = false;
      if (_doctors.isNotEmpty) {
        emit(HomeFullyLoaded(doctors: _doctors, nearbyDoctors: _nearbyDoctors));
      } else {
        emit(NearbyDoctorsLoaded(_nearbyDoctors));
      }
    } catch (e) {
      _isLoadingNearbyDoctors = false;
      emit(HomeError(e.toString()));
    }
  }

  void onDoctorCardTap(int doctorIndex) {
    if (_doctors.isNotEmpty && doctorIndex < _doctors.length) {
      final doctor = _doctors[doctorIndex];
      NavigationService().pushToNamedWithParams(
        RouteNames.doctorProfileView,
        queryParams: {'id': doctor.id.toString()},
      );
    }
  }

  void onDoctorFavoriteTap(int doctorIndex) async {
    if (_doctors.isNotEmpty && doctorIndex < _doctors.length) {
      final doctor = _doctors[doctorIndex];

      try {
        if (!_favoriteManager.isInitialized) {
          await _favoriteManager.initialize();
        }

        final success = await _favoriteManager.toggleFavorite(doctor.id);

        if (success) {
          emit(
            HomeFullyLoaded(doctors: _doctors, nearbyDoctors: _nearbyDoctors),
          );
        } else {}
      } catch (e) {}
    }
  }

  void onDoctorBookTap(int doctorIndex) {
    if (_doctors.isNotEmpty && doctorIndex < _doctors.length) {
      final doctor = _doctors[doctorIndex];
      NavigationService().pushToNamedWithParams(
        RouteNames.doctorProfileView,
        queryParams: {'id': doctor.id.toString()},
      );
    }
  }

  void onNearbyDoctorCardTap(int doctorIndex) {
    if (_nearbyDoctors.isNotEmpty && doctorIndex < _nearbyDoctors.length) {
      final doctor = _nearbyDoctors[doctorIndex];

      NavigationService().pushToNamedWithParams(
        RouteNames.doctorProfileView,

        queryParams: {'id': doctor.doctor.id.toString()},
      );
    }
  }

  void onNearbyDoctorBookTap(int doctorIndex) {
    if (_nearbyDoctors.isNotEmpty && doctorIndex < _nearbyDoctors.length) {
      final doctor = _nearbyDoctors[doctorIndex];
      NavigationService().pushToNamedWithParams(
        RouteNames.doctorProfileView,
        queryParams: {'id': doctor.doctor.id.toString()},
      );
    }
  }

  Future<void> loadDoctorsWithCurrentLocation(BuildContext context) async {
    try {
      emit(HomeLoading());
      final position = await LocationService.getCurrentLocation(context);

      if (position != null) {
        loadDoctors(position.latitude, position.longitude);
        loadNearbyDoctors(position.latitude, position.longitude);
      } else {
        loadDoctors(33.5260220, 36.2864360);
        loadNearbyDoctors(33.5260220, 36.2864360);
      }
    } catch (e) {
      loadDoctors(33.5260220, 36.2864360);
      loadNearbyDoctors(33.5260220, 36.2864360);
    }
  }

  Future<void> loadDoctorsWithLocationPermission(BuildContext context) async {
    try {
      emit(HomeLoading());
      final hasPermission = await LocationService.requestLocationPermission(
        context,
      );

      if (hasPermission) {
        final position = await LocationService.getCurrentLocation(context);

        if (position != null) {
          loadDoctors(position.latitude, position.longitude);
          loadNearbyDoctors(position.latitude, position.longitude);
        } else {
          emit(HomeError('لم يتم الحصول على الموقع'));
        }
      } else {
        emit(HomeError('تم رفض إذن الموقع'));
      }
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }
}
