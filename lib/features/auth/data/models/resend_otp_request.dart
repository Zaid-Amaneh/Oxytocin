class ResendOtpRequest {
  final String phone;

  ResendOtpRequest({required this.phone});

  Map<String, dynamic> toJson() => {'phone': phone};
}
