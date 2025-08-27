import 'package:equatable/equatable.dart';

class BookAppointmentRequestModel extends Equatable {
  final String visitDate;
  final String visitTime;
  final String? notes;

  const BookAppointmentRequestModel({
    required this.visitDate,
    required this.visitTime,
    this.notes,
  });

  Map<String, dynamic> toJson() {
    return {
      'visit_date': visitDate,
      'visit_time': visitTime,
      'notes': notes ?? "",
    };
  }

  @override
  List<Object?> get props => [visitDate, visitTime, notes];
}
