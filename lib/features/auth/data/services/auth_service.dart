import 'package:logger/web.dart';
import 'package:oxytocin/core/constants/api_endpoints.dart';
import 'package:oxytocin/core/errors/failure.dart';
import 'package:oxytocin/features/auth/data/models/change_password_request.dart';
import 'package:oxytocin/features/auth/data/models/change_password_response.dart';
import 'package:oxytocin/features/auth/data/models/forgot_password_request.dart';
import 'package:oxytocin/features/auth/data/models/forgot_password_response.dart';
import 'package:oxytocin/features/auth/data/models/resend_otp_request.dart';
import 'package:oxytocin/features/auth/data/models/sign_in_request.dart';
import 'package:oxytocin/features/auth/data/models/sign_in_response.dart';
import 'package:oxytocin/features/auth/data/models/verify_otp_request.dart';
import 'package:oxytocin/features/auth/data/models/verify_otp_response.dart';
import '../models/user_model.dart';
import '../models/sign_up_request.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  final http.Client client;

  AuthService(this.client);

  Future<UserModel> signUp(SignUpRequest request) async {
    final url = Uri.parse(ApiEndpoints.signUp);
    try {
      final response = await client.post(
        url,
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(request.toJson()),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        return UserModel.fromJson(data);
      } else if (response.statusCode == 400) {
        final errorBody = jsonDecode(response.body);
        if (errorBody['phone'] != null && errorBody['phone'].isNotEmpty) {
          final phoneMessage = errorBody['phone'][0];
          Logger logger = Logger();
          logger.d(phoneMessage);
          if (phoneMessage == 'يجب أن يكون هذا الحقل فريدًا.') {
            throw const PhoneExistsFailure();
          } else {
            throw const PhoneInvalidFailure();
          }
        } else {
          throw const ValidationFailure();
        }
      } else {
        throw const ServerFailure();
      }
    } catch (e) {
      if (e is Failure) {
        rethrow;
      } else {
        throw const NetworkFailure();
      }
    }
  }

  Future<SignInResponse> login(SignInRequest request) async {
    final url = Uri.parse(ApiEndpoints.login);

    try {
      final response = await client.post(
        url,
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(request.toJson()),
      );

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        return SignInResponse.fromJson(json);
      } else if (response.statusCode == 400) {
        final errorBody = jsonDecode(response.body);
        final errors = errorBody['non_field_errors'];
        Logger().d(errors);
        if (errors != null && errors.contains('Invalid credentials')) {
          throw const InvalidCredentialsFailure();
        } else if (errors != null &&
            errors.contains('الرجاء التحقق من رقم هاتفك أولاً.')) {
          throw const UnverifiedPhoneFailure();
        } else {
          throw const ValidationFailure();
        }
      } else {
        throw const ServerFailure();
      }
    } catch (e) {
      if (e is Failure) rethrow;
      throw const NetworkFailure();
    }
  }

  Future<VerifyOtpResponse> verifyOtp(VerifyOtpRequest request) async {
    final url = Uri.parse(ApiEndpoints.verifyOtp);
    try {
      final response = await client.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(request.toJson()),
      );

      if (response.statusCode == 200) {
        return VerifyOtpResponse.fromJson(jsonDecode(response.body));
      } else if (response.statusCode == 401) {
        final error = jsonDecode(response.body);
        Logger().e(error);
        if (error['detail'] != null &&
            error['detail'].toString().contains('رمز التحقق غير صالح')) {
          throw const InvalidOtpFailure();
        }
        throw const ValidationFailure();
      } else {
        throw const ServerFailure();
      }
    } catch (e) {
      if (e is Failure) rethrow;
      throw const NetworkFailure();
    }
  }

  Future<String> resendOtp(ResendOtpRequest request) async {
    final url = Uri.parse(ApiEndpoints.resendOtp);
    try {
      final response = await client.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(request.toJson()),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body)['message'];
      } else {
        throw const ServerFailure();
      }
    } catch (e) {
      if (e is Failure) rethrow;
      throw const NetworkFailure();
    }
  }

  Future<ForgotPasswordResponse> forgotPassword(
    ForgotPasswordRequest request,
  ) async {
    final url = Uri.parse(ApiEndpoints.forgetPasswordSendOtp);
    final headers = {'Content-Type': 'application/json'};

    try {
      final response = await client.post(
        url,
        headers: headers,
        body: jsonEncode(request.toJson()),
      );

      if (response.statusCode == 200) {
        return ForgotPasswordResponse.fromJson(jsonDecode(response.body));
      } else {
        final decoded = jsonDecode(response.body);
        if (decoded is List &&
            decoded.first.toString().contains('رقم الجوال غير موجود')) {
          throw const PhoneNotFoundFailure();
        } else {
          throw const ServerFailure();
        }
      }
    } catch (e) {
      if (e is Failure) rethrow;
      throw const NetworkFailure();
    }
  }

  Future<VerifyOtpResponse> verifyForgotPasswordOtp(
    VerifyOtpRequest request,
  ) async {
    final url = Uri.parse(ApiEndpoints.verifyForgotPasswordOtp);

    try {
      final response = await client.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(request.toJson()),
      );

      if (response.statusCode == 200) {
        return VerifyOtpResponse.fromJson(jsonDecode(response.body));
      } else if (response.statusCode == 401 || response.statusCode == 400) {
        final error = jsonDecode(response.body);
        Logger().e(error);
        if (error['detail'] != null &&
            error['detail'].toString().contains('رمز التحقق غير صالح')) {
          throw const InvalidOtpFailure();
        }
        throw const ValidationFailure();
      } else {
        throw const ServerFailure();
      }
    } catch (e) {
      if (e is Failure) rethrow;
      throw const NetworkFailure();
    }
  }

  Future<ChangePasswordResponse> changePassword(
    ChangePasswordRequest request,
    String accessToken,
  ) async {
    final url = Uri.parse(ApiEndpoints.changePassword);

    try {
      final response = await client.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
        body: jsonEncode(request.toJson()),
      );

      if (response.statusCode == 200) {
        return ChangePasswordResponse.fromJson(jsonDecode(response.body));
      } else if (response.statusCode == 401) {
        final error = jsonDecode(response.body);
        Logger().e(error);
        if (error['code'] == 'token_not_valid') {
          throw const InvalidTokenFailure();
        }
        throw const ValidationFailure();
      } else {
        throw const ServerFailure();
      }
    } catch (e) {
      if (e is Failure) rethrow;
      throw const NetworkFailure();
    }
  }
}
