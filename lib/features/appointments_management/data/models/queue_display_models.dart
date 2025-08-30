enum PatientStatus { completed, inProgress, waiting, absent, cancelled }

class QueuePatient {
  final String appointmentTime;
  final String? actualEntryTime;
  final String? actualExitTime;
  final PatientStatus status;
  final int orderNumber;

  QueuePatient({
    required this.appointmentTime,
    this.actualEntryTime,
    this.actualExitTime,
    required this.status,
    required this.orderNumber,
  });
}
