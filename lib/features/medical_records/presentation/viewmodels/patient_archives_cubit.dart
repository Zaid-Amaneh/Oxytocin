import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oxytocin/features/medical_records/data/services/archives_service.dart';

import 'patient_archives_state.dart';
import 'package:oxytocin/core/errors/failure.dart';

class PatientArchivesCubit extends Cubit<PatientArchivesState> {
  final ArchivesService _archivesService;

  PatientArchivesCubit(this._archivesService) : super(PatientArchivesInitial());

  Future<void> fetchDoctorArchives(int doctorId) async {
    emit(PatientArchivesLoading());
    try {
      final response = await _archivesService.getPatientArchivesForDoctor(
        doctorId: doctorId,
      );
      emit(PatientArchivesLoaded(response));
    } on Failure catch (failure) {
      emit(PatientArchivesError(failure.toString()));
    } catch (e) {
      emit(PatientArchivesError('حدث خطأ غير متوقع: ${e.toString()}'));
    }
  }
}
