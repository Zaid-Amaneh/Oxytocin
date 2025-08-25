class CreatedEvaluationModel {
  final int id;
  final PatientModel patient;
  final AppointmentSummaryModel appointment;
  final int rate;
  final String? comment;
  final bool editable;
  final String createdAt;
  final String updatedAt;

  CreatedEvaluationModel({
    required this.id,
    required this.patient,
    required this.appointment,
    required this.rate,
    this.comment,
    required this.editable,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CreatedEvaluationModel.fromJson(Map<String, dynamic> json) {
    return CreatedEvaluationModel(
      id: json['id'],
      patient: PatientModel.fromJson(json['patient']),
      appointment: AppointmentSummaryModel.fromJson(json['appointment']),
      rate: json['rate'],
      comment: json['comment'],
      editable: json['editable'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}

class PatientModel {
  final PatientUserModel user;
  final String address;
  final double longitude;
  final double latitude;
  final String job;
  final String bloodType;

  PatientModel({
    required this.user,
    required this.address,
    required this.longitude,
    required this.latitude,
    required this.job,
    required this.bloodType,
  });

  factory PatientModel.fromJson(Map<String, dynamic> json) {
    return PatientModel(
      user: PatientUserModel.fromJson(json['user']),
      address: json['address'],
      longitude: (json['longitude'] as num).toDouble(),
      latitude: (json['latitude'] as num).toDouble(),
      job: json['job'],
      bloodType: json['blood_type'],
    );
  }
}

class PatientUserModel {
  final int id;
  final String firstName;
  final String lastName;
  final String phone;
  final String? image;
  final String gender;

  PatientUserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phone,
    this.image,
    required this.gender,
  });

  factory PatientUserModel.fromJson(Map<String, dynamic> json) {
    return PatientUserModel(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      phone: json['phone'],
      image: json['image'],
      gender: json['gender'],
    );
  }
}

class AppointmentSummaryModel {
  final int id;
  final String visitDate;
  final String visitTime;
  final String status;
  final String createdAt;
  final String updatedAt;

  AppointmentSummaryModel({
    required this.id,
    required this.visitDate,
    required this.visitTime,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory AppointmentSummaryModel.fromJson(Map<String, dynamic> json) {
    return AppointmentSummaryModel(
      id: json['id'],
      visitDate: json['visit_date'],
      visitTime: json['visit_time'],
      status: json['status'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
