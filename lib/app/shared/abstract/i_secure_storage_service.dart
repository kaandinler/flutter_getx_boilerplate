abstract class ISecureStorageService {
  Future<void> writeSecure(String key, dynamic value);
  Future<dynamic> readSecure({required String key});
  Future<void> deleteSecure({required String key});
  Future<void> deleteAllSecure();
}
