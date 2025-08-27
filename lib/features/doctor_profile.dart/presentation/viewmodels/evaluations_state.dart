import 'package:equatable/equatable.dart';
import 'package:oxytocin/features/doctor_profile.dart/data/models/paginated_evaluations_response.dart';

abstract class EvaluationsState extends Equatable {
  const EvaluationsState();

  @override
  List<Object> get props => [];
}

class EvaluationsInitial extends EvaluationsState {}

class EvaluationsLoading extends EvaluationsState {}

class EvaluationsLoaded extends EvaluationsState {
  final List<EvaluationModel> evaluations;
  final bool hasReachedMax;

  const EvaluationsLoaded({
    required this.evaluations,
    required this.hasReachedMax,
  });

  EvaluationsLoaded copyWith({
    List<EvaluationModel>? evaluations,
    bool? hasReachedMax,
  }) {
    return EvaluationsLoaded(
      evaluations: evaluations ?? this.evaluations,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [evaluations, hasReachedMax];
}

class EvaluationsError extends EvaluationsState {
  final String message;

  const EvaluationsError(this.message);

  @override
  List<Object> get props => [message];
}
