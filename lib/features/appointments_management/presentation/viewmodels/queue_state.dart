import 'package:equatable/equatable.dart';
import 'package:oxytocin/features/appointments_management/data/models/queue_response_model.dart';

abstract class QueueState extends Equatable {
  const QueueState();

  @override
  List<Object> get props => [];
}

class QueueInitial extends QueueState {}

class QueueLoading extends QueueState {}

class QueueLoaded extends QueueState {
  final QueueResponse queueResponse;

  const QueueLoaded(this.queueResponse);

  @override
  List<Object> get props => [queueResponse];
}

class QueueError extends QueueState {
  final String message;

  const QueueError(this.message);

  @override
  List<Object> get props => [message];
}
