import 'package:flutter/foundation.dart';
import 'package:getx_boilerplate/app/shared/abstract/i_secure_storage_service.dart';

class AuthService {
  final ISecureStorageService _storage;
  AuthService(this._storage);

  static const _kAccess = 'access_token';
  static const _kRefresh = 'refresh_token';

  Future<String?> getAccessToken() async {
    final v = await _storage.readSecure(key: _kAccess);
    return v as String?;
  }
  Future<String?> getRefreshToken() async {
    final v = await _storage.readSecure(key: _kRefresh);
    return v as String?;
  }

  Future<void> setTokens({required String accessToken, String? refreshToken}) async {
    await _storage.writeSecure(_kAccess, accessToken);
    if (refreshToken != null) {
      await _storage.writeSecure(_kRefresh, refreshToken);
    }
  }

  Future<bool> clearTokens() async {
    await _storage.deleteSecure(key: _kAccess);
    await _storage.deleteSecure(key: _kRefresh);
    return true;
  }

  /// Implement your refresh logic here. Return new access token if refreshed.
  Future<String?> refreshToken() async {
    if (kDebugMode) {
      // Placeholder. Implement API call to refresh with stored refresh token.
    }
    return null;
  }
}
