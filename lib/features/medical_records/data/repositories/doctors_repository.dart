import 'package:oxytocin/core/errors/failure.dart';
import 'package:oxytocin/features/medical_records/data/models/doctors_by_specialty_response.dart';
import 'package:oxytocin/features/medical_records/data/services/doctors_service.dart';

abstract class DoctorsRepository {
  Future<DoctorsBySpecialtyResponse> getDoctorsBySpecialty({
    required int specialtyId,
    int page = 1,
  });
}

class DoctorsRepositoryImpl implements DoctorsRepository {
  final DoctorsService doctorsService;

  DoctorsRepositoryImpl(this.doctorsService);

  @override
  Future<DoctorsBySpecialtyResponse> getDoctorsBySpecialty({
    required int specialtyId,
    int page = 1,
  }) async {
    try {
      return await doctorsService.getDoctorsBySpecialty(
        specialtyId: specialtyId,
        page: page,
      );
    } on Failure {
      rethrow;
    } catch (e) {
      throw const ServerFailure();
    }
  }
}
