import 'package:oxytocin/features/home/data/model/doctor_model.dart';
import 'package:oxytocin/features/home/data/model/nearby_doctor_model.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<DoctorModel> doctors;
  HomeLoaded(this.doctors);
}

class HomeError extends HomeState {
  final String message;
  HomeError(this.message);
}

class NearbyDoctorsLoaded extends HomeState {
  final List<NearbyDoctorModel> nearbyDoctors;
  NearbyDoctorsLoaded(this.nearbyDoctors);
}

class HomeFullyLoaded extends HomeState {
  final List<DoctorModel> doctors;
  final List<NearbyDoctorModel> nearbyDoctors;
  HomeFullyLoaded({required this.doctors, required this.nearbyDoctors});
}
