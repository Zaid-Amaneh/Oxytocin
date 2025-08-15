import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oxytocin/core/constants/api_endpoints.dart';
import 'package:oxytocin/features/home/data/model/doctor_model.dart';
import 'package:oxytocin/features/home/data/model/nearby_doctor_model.dart';
import 'package:oxytocin/features/home/data/services/doctors_service.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final DoctorsService _doctorsService;

  List<DoctorModel> _doctors = [];
  List<NearbyDoctorModel> _nearbyDoctors = [];
  bool _isLoadingDoctors = false;
  bool _isLoadingNearbyDoctors = false;

  HomeCubit()
    : _doctorsService = DoctorsService(baseUrl: ApiEndpoints.baseURL),
      super(HomeInitial());

  List<DoctorModel> get doctors => _doctors;
  List<NearbyDoctorModel> get nearbyDoctors => _nearbyDoctors;
  bool get isLoadingDoctors => _isLoadingDoctors;
  bool get isLoadingNearbyDoctors => _isLoadingNearbyDoctors;

  void loadDoctors() async {
    try {
      _isLoadingDoctors = true;
      if (_nearbyDoctors.isEmpty) {
        emit(HomeLoading());
      }
      final doctors = await _doctorsService.getHighestRatedDoctors();
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
      // Navigate to doctor details page
      // Navigator.pushNamed(context, '/doctor-details', arguments: doctor);
    }
  }

  void onDoctorFavoriteTap(int doctorIndex) {
    if (_doctors.isNotEmpty && doctorIndex < _doctors.length) {
      final doctor = _doctors[doctorIndex];
    }
  }

  void onDoctorBookTap(int doctorIndex) {
    if (_doctors.isNotEmpty && doctorIndex < _doctors.length) {
      final doctor = _doctors[doctorIndex];
    }
  }

  void onNearbyDoctorCardTap(int doctorIndex) {
    if (_nearbyDoctors.isNotEmpty && doctorIndex < _nearbyDoctors.length) {
      final doctor = _nearbyDoctors[doctorIndex];
    }
  }

  void onNearbyDoctorBookTap(int doctorIndex) {
    if (_nearbyDoctors.isNotEmpty && doctorIndex < _nearbyDoctors.length) {
      final doctor = _nearbyDoctors[doctorIndex];
    }
  }
}
