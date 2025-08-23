import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oxytocin/features/doctor_profile.dart/data/services/doctor_profile_service.dart';
import 'evaluations_state.dart';

class EvaluationsCubit extends Cubit<EvaluationsState> {
  final DoctorProfileService _doctorProfileService;

  int _page = 1;

  EvaluationsCubit(this._doctorProfileService) : super(EvaluationsInitial());

  Future<void> fetchEvaluations(int clinicId) async {
    final currentState = state;
    if (currentState is EvaluationsLoaded && currentState.hasReachedMax) {
      return;
    }

    try {
      if (state is EvaluationsInitial) {
        emit(EvaluationsLoading());
      }

      final response = await _doctorProfileService.fetchClinicEvaluations(
        clinicId: clinicId,
        page: _page,
      );

      _page++;

      final hasReachedMax = response.next == null;

      final newEvaluations = response.results;
      final allEvaluations = (currentState is EvaluationsLoaded)
          ? currentState.evaluations + newEvaluations
          : newEvaluations;

      emit(
        EvaluationsLoaded(
          evaluations: allEvaluations,
          hasReachedMax: hasReachedMax,
        ),
      );
    } catch (e) {
      emit(EvaluationsError(e.toString()));
    }
  }
}
