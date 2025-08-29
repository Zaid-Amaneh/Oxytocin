import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oxytocin/core/errors/failure.dart';
import 'package:oxytocin/features/medical_records/data/repositories/doctors_repository.dart';
import 'doctors_state.dart';

class DoctorsCubit extends Cubit<DoctorsState> {
  final DoctorsRepository _repository;

  DoctorsCubit(this._repository) : super(DoctorsInitial());

  Future<void> fetchDoctors(int specialtyId) async {
    emit(DoctorsLoading());
    try {
      final response = await _repository.getDoctorsBySpecialty(
        specialtyId: specialtyId,
      );
      emit(DoctorsLoaded(response));
    } on Failure catch (e) {
      emit(DoctorsError(e.toString()));
    } catch (e) {
      emit(const DoctorsError('An unexpected error occurred.'));
    }
  }
}
