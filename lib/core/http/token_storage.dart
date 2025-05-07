import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class TokenStorage {
  Future<String?> getAccessToken();
  Future<String?> getRefreshToken();
  Future<void> saveTokens(String accessToken, [String refreshToken]);
  Future<void> clearTokens();
}

// 实现示例 (使用 flutter_secure_storage)
class SecureTokenStorage implements TokenStorage {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  @override
  Future<String?> getAccessToken() => _storage.read(key: 'access_token');

  @override
  Future<String?> getRefreshToken() => _storage.read(key: 'refresh_token');

  @override
  Future<void> saveTokens(String accessToken, [String? refreshToken]) async {
    await Future.wait([
      _storage.write(key: 'access_token', value: accessToken),
      // _storage.write(key: 'refresh_token', value: refreshToken),
    ]);
  }

  @override
  Future<void> clearTokens() async {
    await Future.wait([
      _storage.delete(key: 'access_token'),
      // _storage.delete(key: 'refresh_token'),
    ]);
  }
}