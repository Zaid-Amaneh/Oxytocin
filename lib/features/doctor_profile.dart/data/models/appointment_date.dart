import 'visit_time_model.dart';

class AppointmentDate {
  final String visitDate;
  final List<VisitTime> visitTimes;

  AppointmentDate({required this.visitDate, required this.visitTimes});

  factory AppointmentDate.fromJson(Map<String, dynamic> json) {
    var timesList = json['visit_times'] as List;
    List<VisitTime> visitTimes = timesList
        .map((time) => VisitTime.fromJson(time))
        .toList();

    return AppointmentDate(
      visitDate: json['visit_date'] ?? '',
      visitTimes: visitTimes,
    );
  }
}
