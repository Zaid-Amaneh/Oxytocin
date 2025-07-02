class ChangePasswordRequest {
  final String newPassword;

  ChangePasswordRequest({required this.newPassword});

  Map<String, dynamic> toJson() {
    return {'new_password': newPassword};
  }
}
