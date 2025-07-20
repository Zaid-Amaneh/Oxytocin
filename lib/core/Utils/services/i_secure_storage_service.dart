abstract class ISecureStorageService {
  Future<void> saveAccessToken(String token);
  Future<String?> getAccessToken();
  Future<bool> hasAccessToken();
  Future<void> deleteAccessToken();

  Future<void> saveRefreshToken(String token);
  Future<String?> getRefreshToken();
  Future<bool> hasRefreshToken();
  Future<void> deleteRefreshToken();
}
