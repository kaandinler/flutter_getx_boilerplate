import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:getx_boilerplate/app/shared/abstract/i_secure_storage_service.dart';

class SecureStorageService extends GetxService implements ISecureStorageService {
  // Initialize FlutterSecureStorage with AndroidOptions
  late final FlutterSecureStorage _secureStorage;

  SecureStorageService() {
    _secureStorage = FlutterSecureStorage(
      aOptions: _getAndroidOptions(),
    );
  }

  // Method to return AndroidOptions configured for encrypted SharedPreferences
  AndroidOptions _getAndroidOptions() => const AndroidOptions(
        encryptedSharedPreferences: true,
      );

  @override
  Future<void> writeSecure(String key, value) async {
    return await _secureStorage.write(key: key, value: value);
  }

  @override
  Future<String?> readSecure({required String key}) async {
    return await _secureStorage.read(key: key);
  }

  @override
  Future<void> deleteSecure({required String key}) async {
    await _secureStorage.delete(key: key);
  }

  @override
  Future<void> deleteAllSecure() async {
    await _secureStorage.deleteAll();
  }
}
