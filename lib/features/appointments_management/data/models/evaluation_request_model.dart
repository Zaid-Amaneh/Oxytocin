class EvaluationRequestModel {
  final int appointmentId;
  final int rate;
  final String? comment;

  EvaluationRequestModel({
    required this.appointmentId,
    required this.rate,
    this.comment,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'appointment_id': appointmentId,
      'rate': rate,
    };
    if (comment != null && comment!.isNotEmpty) {
      data['comment'] = comment;
    }
    return data;
  }
}
