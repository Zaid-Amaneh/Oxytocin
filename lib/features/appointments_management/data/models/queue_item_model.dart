class QueueItem {
  final String status;
  final String visitTime;
  final String? actualStartTime;
  final String? actualEndTime;

  QueueItem({
    required this.status,
    required this.visitTime,
    this.actualStartTime,
    this.actualEndTime,
  });

  factory QueueItem.fromJson(Map<String, dynamic> json) {
    return QueueItem(
      status: json['status'] as String,
      visitTime: json['visit_time'] as String,
      actualStartTime: json['actual_start_time'] as String?,
      actualEndTime: json['actual_end_time'] as String?,
    );
  }
}
