import 'queue_item_model.dart';

class QueueResponse {
  final int estimatedWaitMinutes;
  final List<QueueItem> queue;

  QueueResponse({required this.estimatedWaitMinutes, required this.queue});

  factory QueueResponse.fromJson(Map<String, dynamic> json) {
    var queueList = json['queue'] as List;
    List<QueueItem> items = queueList
        .map((i) => QueueItem.fromJson(i))
        .toList();

    return QueueResponse(
      estimatedWaitMinutes: json['estimated_wait_minutes'] as int,
      queue: items,
    );
  }
}
