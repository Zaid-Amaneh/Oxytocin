import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oxytocin/features/home/data/model/doctor_model.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  void loadDoctors() async {
    emit(HomeLoading());
    await Future.delayed(Duration(seconds: 1));
    emit(
      HomeLoaded([
        DoctorModel(
          name: 'د. سامر الخطيب',
          specialty: 'أخصائي الأمراض الجلدية',
          clinic: 'مستشفى الشامي',
          distance: 1.2,
          imageUrl: 'assets/images/doctor1.png',
          rating: 4.6,
          reviewsCount: 366,
          nextAvailableTime: 'اليوم الساعة 4:30 مساءً',
        ),
        DoctorModel(
          name: 'د. زياد المطيري',
          specialty: 'جلدية وتجميل',
          clinic: 'عيادات الجمال الصحي، طريق الأمير تركي الأول',
          distance: 0.8,
          imageUrl: 'assets/images/doctor2.png',
          rating: 4.8,
          reviewsCount: 120,
          nextAvailableTime: 'غدًا الساعة 10:00 صباحًا',
        ),
      ]),
    );
  }

  void onDoctorCardTap(int doctorIndex) {
    if (state is HomeLoaded) {
      final currentState = state as HomeLoaded;
      final doctor = currentState.doctors[doctorIndex];
      print('Doctor card tapped: ${doctor.name}');
    }
  }

  void onDoctorFavoriteTap(int doctorIndex) {
    if (state is HomeLoaded) {
      final currentState = state as HomeLoaded;
      final doctor = currentState.doctors[doctorIndex];
      print('Doctor favorite tapped: ${doctor.name}');
    }
  }

  void onDoctorBookTap(int doctorIndex) {
    if (state is HomeLoaded) {
      final currentState = state as HomeLoaded;
      final doctor = currentState.doctors[doctorIndex];
      print('Doctor book tapped: ${doctor.name}');
    }
  }

  void onNearbyDoctorCardTap(int doctorIndex) {
    if (state is HomeLoaded) {
      final currentState = state as HomeLoaded;
      final doctor = currentState.doctors[doctorIndex];
      print('Nearby doctor card tapped: ${doctor.name}');
    }
  }

  void onNearbyDoctorBookTap(int doctorIndex) {
    if (state is HomeLoaded) {
      final currentState = state as HomeLoaded;
      final doctor = currentState.doctors[doctorIndex];
      print('Nearby doctor book tapped: ${doctor.name}');
    }
  }
}
