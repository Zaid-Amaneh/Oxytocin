// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:logger/logger.dart';
// import 'package:oxytocin/features/appointments_management/data/models/evaluation_request_model.dart';
// import 'package:oxytocin/features/appointments_management/data/services/evaluation_service.dart';
// import 'evaluation_state.dart';

// class EvaluationCubit extends Cubit<EvaluationState> {
//   final EvaluationService _evaluationService;

//   EvaluationCubit({required EvaluationService evaluationService})
//     : _evaluationService = evaluationService,
//       super(EvaluationInitial());
//   Future<void> submitEvaluation({
//     required int appointmentId,
//     required int rate,
//     String? comment,
//   }) async {
//     Logger().i('EVALUATION CUBIT CREATED - HASHCODE: $hashCode');
//     emit(EvaluationLoading());

//     final requestModel = EvaluationRequestModel(
//       appointmentId: appointmentId,
//       rate: rate,
//       comment: comment,
//     );

//     try {
//       final createdEvaluation = await _evaluationService.submitEvaluation(
//         evaluationData: requestModel,
//       );
//       emit(EvaluationSuccess(createdEvaluation));
//     } catch (e) {
//       Logger().d(e);
//       emit(
//         const EvaluationFailure(
//           "An unexpected error occurred. Please try again.",
//         ),
//       );
//     }
//   }
// }
