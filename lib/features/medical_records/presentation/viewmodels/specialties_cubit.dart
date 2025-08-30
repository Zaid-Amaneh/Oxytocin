import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oxytocin/core/errors/failure.dart';
import 'package:oxytocin/features/medical_records/data/services/specialties_service.dart';
import 'specialties_state.dart';

class SpecialtiesCubit extends Cubit<SpecialtiesState> {
  final SpecialtiesService _specialtiesService;

  SpecialtiesCubit(this._specialtiesService) : super(SpecialtiesInitial());

  Future<void> fetchSpecialties() async {
    emit(SpecialtiesLoading());
    try {
      final specialties = await _specialtiesService.getSpecialties();
      emit(SpecialtiesSuccess(specialties));
    } on Failure catch (e) {
      emit(SpecialtiesFailure(e.toString()));
    } catch (e) {
      emit(
        const SpecialtiesFailure(
          'An unexpected error occurred. Please try again.',
        ),
      );
    }
  }
}
