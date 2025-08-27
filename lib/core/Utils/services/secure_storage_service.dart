import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'i_secure_storage_service.dart';

class SecureStorageService implements ISecureStorageService {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  static const String _accessTokenKey = 'access_token';
  static const String _refreshTokenKey = 'refresh_token';
  @override
  Future<void> saveAccessToken(String token) async {
    await _storage.write(key: _accessTokenKey, value: token);
  }

  @override
  Future<String?> getAccessToken() async {
    return await _storage.read(key: _accessTokenKey);
  }

  @override
  Future<bool> hasAccessToken() async {
    return await _storage.containsKey(key: _accessTokenKey);
  }

  @override
  Future<void> deleteAccessToken() async {
    await _storage.delete(key: _accessTokenKey);
  }

  @override
  Future<void> saveRefreshToken(String token) async {
    await _storage.write(key: _refreshTokenKey, value: token);
  }

  @override
  Future<String?> getRefreshToken() async {
    return await _storage.read(key: _refreshTokenKey);
  }

  @override
  Future<bool> hasRefreshToken() async {
    return await _storage.containsKey(key: _refreshTokenKey);
  }

  @override
  Future<void> deleteRefreshToken() async {
    await _storage.delete(key: _refreshTokenKey);
  }

  @override
  Future<void> deleteAll() async {
    await _storage.deleteAll();

    final hasAccess = await hasAccessToken();
    final hasRefresh = await hasRefreshToken();
  }
}
