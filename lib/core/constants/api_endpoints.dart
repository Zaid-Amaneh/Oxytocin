class ApiEndpoints {
  static const String baseURL = 'https://actively-sound-tiger.ngrok-free.app';
  // "http://192.168.1.106:8000";
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
  static const String doctorSearch = "$baseURL/api/doctors/search/";
  static const String refreshToken = "$baseURL/api/users/refresh-token/";
  static const String userProfile = '$baseURL/api/patients/me/';
  static const String highestRatedDoctors = '/api/doctors/highest-rated/';
  static const String doctorById = '/api/doctors';
  static const String nearestDoctors = '/api/doctors/clinics/nearest/';
  static const String doctorProfile = "$baseURL/api/doctors/";
  static const String evaluations = "$baseURL/api/evaluations/";
  static const String favorites = "$baseURL/api/patients/favorites/";
  static const String appointmentDate = "$baseURL/api/appointments/";
  static const String appointments = '$baseURL/api/appointments/';
}
