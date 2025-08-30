import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:oxytocin/core/errors/failure.dart';
import 'package:oxytocin/features/appointments_management/data/services/queue_service.dart';
import 'queue_state.dart';

class QueueCubit extends Cubit<QueueState> {
  final QueueService _queueService;
  final Logger _logger = Logger();

  QueueCubit(this._queueService) : super(QueueInitial());

  Future<void> fetchAppointmentQueue({required int appointmentId}) async {
    try {
      _logger.i("Fetching queue for appointment ID: $appointmentId");
      emit(QueueLoading());

      final queueData = await _queueService.getAppointmentQueue(
        appointmentId: appointmentId,
      );

      emit(QueueLoaded(queueData));
      _logger.i("Successfully fetched and loaded queue data.");
    } on Failure catch (e) {
      _logger.e("A known failure occurred: ${e.runtimeType}");
      emit(QueueError(e.toString()));
    } catch (e) {
      _logger.e("An unexpected error occurred: $e");
      emit(QueueError(e.toString()));
    }
  }
}
