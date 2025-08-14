import 'package:oxytocin/core/constants/api_endpoints.dart';

class UserModel {
  final int id;
  final String firstName;
  final String lastName;
  final String image;

  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.image,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    String fullImageUrl = json['image'] ?? '';
    String imagePath = fullImageUrl.replaceFirst(
      'http://localhost:8000',
      ApiEndpoints.baseURL,
    );
    return UserModel(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      image: imagePath,
    );
  }
}
