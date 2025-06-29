class UserModel {
  final int id;
  final String firstName;
  final String lastName;
  final String phone;
  final String role;

  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.role,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json['id'],
    firstName: json['first_name'],
    lastName: json['last_name'],
    phone: json['phone'],
    role: json['role'],
  );
}
