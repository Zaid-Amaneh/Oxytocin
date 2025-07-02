import 'package:oxytocin/core/Utils/services/i_secure_storage_service.dart';
import 'package:oxytocin/core/Utils/services/secure_storage_service.dart';
import 'package:oxytocin/features/auth/data/models/change_password_request.dart';
import 'package:oxytocin/features/auth/data/models/change_password_response.dart';
import 'package:oxytocin/features/auth/data/services/auth_service.dart';

class ChangePasswordUseCase {
  final AuthService authService;

  ChangePasswordUseCase({required this.authService});

  Future<ChangePasswordResponse> call(ChangePasswordRequest request) async {
    final ISecureStorageService tokenStorage = SecureStorageService();
    String? accessToken = await tokenStorage.getAccessToken();
    return await authService.changePassword(request, accessToken!);
  }
}
