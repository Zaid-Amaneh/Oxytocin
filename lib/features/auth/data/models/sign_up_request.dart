class SignUpRequest {
  final String firstName;
  final String lastName;
  final String phone;
  final String password;
  final String confirmPassword;

  SignUpRequest({
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.password,
    required this.confirmPassword,
  });

  Map<String, dynamic> toJson() {
    return {
      "first_name": firstName,
      "last_name": lastName,
      "phone": phone,
      "password": password,
      "password_confirm": confirmPassword,
    };
  }
}
