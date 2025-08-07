class ApiEndpoints {
  static const String baseURL =
      // 'https://actively-sound-tiger.ngrok-free.app';
      "http://192.168.1.102:8000";
  static const String signUp = '$baseURL/api/users/';
  static const String login = '$baseURL/api/patients/login/';
  static const String verifyOtp = '$baseURL/api/users/otp/signup/verify/';
  static const String resendOtp = '$baseURL/api/users/otp/signup/send/';
  static const String forgetPasswordSendOtp =
      '$baseURL/api/users/forget-password/send-otp/';
  static const String verifyForgotPasswordOtp =
      '$baseURL/api/users/forget-password/verify-otp/';
  static const String changePassword =
      '$baseURL/api/users/forget-password/add-new-password/';
}
