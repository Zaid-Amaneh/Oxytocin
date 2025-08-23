import 'package:equatable/equatable.dart';

class ClinicModel extends Equatable {
  final String address;
  final double longitude;
  final double latitude;
  final String phone;

  const ClinicModel({
    required this.address,
    required this.longitude,
    required this.latitude,
    required this.phone,
  });

  factory ClinicModel.fromJson(Map<String, dynamic> json) {
    return ClinicModel(
      address: json['address'],
      longitude: (json['longitude'] as num).toDouble(),
      latitude: (json['latitude'] as num).toDouble(),
      phone: json['phone'],
    );
  }

  @override
  List<Object?> get props => [address, longitude, latitude, phone];
}
