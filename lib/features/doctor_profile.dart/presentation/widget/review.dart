// يمكنك وضع هذا الكلاس في ملف منفصل، مثلاً 'review_model.dart'
class Review {
  final String patientName;
  final String comment;
  final double rating;

  Review({
    required this.patientName,
    required this.comment,
    required this.rating,
  });
}

class AppointmentModel {
  final DateTime date;
  final List<String> availableTimes; // بصيغة 24 ساعة مثل "14:30"

  AppointmentModel({required this.date, required this.availableTimes});
}
