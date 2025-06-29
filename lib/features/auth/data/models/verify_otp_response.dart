class VerifyOtpResponse {
  final String accessToken;
  final String refreshToken;
  final int expiresIn;

  VerifyOtpResponse({
    required this.accessToken,
    required this.refreshToken,
    required this.expiresIn,
  });

  factory VerifyOtpResponse.fromJson(Map<String, dynamic> json) {
    return VerifyOtpResponse(
      accessToken: json['access_token'],
      refreshToken: json['refresh_token'],
      expiresIn: json['expires_in'],
    );
  }
}
