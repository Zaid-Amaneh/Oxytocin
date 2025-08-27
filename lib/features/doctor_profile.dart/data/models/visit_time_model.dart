class VisitTime {
  final String visitTime;
  final bool isBooked;

  VisitTime({required this.visitTime, required this.isBooked});

  factory VisitTime.fromJson(Map<String, dynamic> json) {
    return VisitTime(
      visitTime: json['visit_time'] ?? '',
      isBooked: json['is_booked'] ?? false,
    );
  }
}
