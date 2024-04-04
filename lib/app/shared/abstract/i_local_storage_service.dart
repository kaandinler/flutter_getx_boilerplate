abstract class ILocalStorageService {
  //Default methods of the abstract class
  Future<void> init();
  Future<void> save(String key, dynamic value);
  Future<dynamic> read(String key);
  Future<void> delete(String key);
  Future<void> clear();

  bool isDarkTheme = false;

  String locale = 'en';
}
