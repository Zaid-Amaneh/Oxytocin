import 'package:oxytocin/features/appointments_management/data/models/queue_display_models.dart';
import 'package:oxytocin/features/appointments_management/data/models/queue_item_model.dart';

class QueueMapper {
  PatientStatus mapApiStatusToUiStatus(String apiStatus) {
    switch (apiStatus) {
      case 'completed':
        return PatientStatus.completed;
      case 'in_consultation':
        return PatientStatus.inProgress;
      case 'waiting':
        return PatientStatus.waiting;
      case 'absent':
        return PatientStatus.absent;
      case 'cancelled':
        return PatientStatus.cancelled;
      default:
        return PatientStatus.waiting;
    }
  }

  List<QueuePatient> mapQueueItemsToQueuePatients(List<QueueItem> items) {
    return items.asMap().entries.map((entry) {
      int index = entry.key;
      QueueItem item = entry.value;

      return QueuePatient(
        orderNumber: index + 1,
        appointmentTime: item.visitTime,
        actualEntryTime: item.actualStartTime,
        actualExitTime: item.actualEndTime,
        status: mapApiStatusToUiStatus(item.status),
      );
    }).toList();
  }

  double calculateAverageDelay(List<Map<String, String>> appointments) {
    if (appointments.isEmpty) return 0;

    double totalDelayMinutes = 0;

    for (var appt in appointments) {
      final expected = appt['expected']!;
      final actual = appt['actual']!;
      totalDelayMinutes += calculateDelayInMinutes(expected, actual);
    }

    return totalDelayMinutes / appointments.length;
  }

  int calculateDelayInMinutes(String expectedTime, String actualTime) {
    final expected = DateTime.parse("2000-01-01 $expectedTime");
    final actual = DateTime.parse("2000-01-01 $actualTime");

    final difference = actual.difference(expected).inMinutes;
    return difference < 0 ? 0 : difference;
  }

  double calculateAverageExaminationTime(List<Map<String, String>> sessions) {
    if (sessions.isEmpty) return 0;
    double totalExaminationMinutes = 0;
    for (var session in sessions) {
      final enter = session['enter']!;
      final exit = session['exit']!;
      totalExaminationMinutes += calculateExaminationDuration(enter, exit);
    }
    return totalExaminationMinutes / sessions.length;
  }

  int calculateExaminationDuration(String entryTime, String exitTime) {
    final entry = DateTime.parse("2000-01-01 $entryTime");
    final exit = DateTime.parse("2000-01-01 $exitTime");

    final difference = exit.difference(entry).inMinutes;
    return difference < 0 ? 0 : difference;
  }
}
