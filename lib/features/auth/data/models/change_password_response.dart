class ChangePasswordResponse {
  final String detail;

  ChangePasswordResponse({required this.detail});

  factory ChangePasswordResponse.fromJson(Map<String, dynamic> json) {
    return ChangePasswordResponse(detail: json['detail']);
  }
}
