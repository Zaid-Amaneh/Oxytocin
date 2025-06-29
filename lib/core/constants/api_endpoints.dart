class ApiEndpoints {
  static const String baseURL = 'https://actively-sound-tiger.ngrok-free.app';
  static const String signUp = '$baseURL/api/users/';
  static const String login = '$baseURL/api/patients/login/';
  static const String verifyOtp = '$baseURL/api/users/otp/signup/verify/';
  static const String resendOtp = '$baseURL/api/users/otp/signup/send/';
}
