// ignore_for_file: constant_identifier_names

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:getx_boilerplate/app/shared/abstract/i_local_storage_service.dart';

class LocalStorageService extends GetxService implements ILocalStorageService {
  final GetStorage _getStorage = GetStorage();

  LocalStorageService() {
    init();
  }

  @override
  Future<void> init() async {
    await _getStorage.initStorage;
  }

  @override
  Future<void> save(String key, dynamic value) async {
    await _getStorage.write(key, value);
  }

  @override
  Future<dynamic> read(String key) async {
    return await _getStorage.read(key);
  }

  @override
  Future<void> delete(String key) async {
    await _getStorage.remove(key);
  }

  @override
  Future<void> clear() async {
    //clear all data.
    await _getStorage.erase();
  }

  @override
  bool get isDarkTheme => _getStorage.read(LOCAL_STORAGE_THEME_MODE) ?? false;

  @override
  set isDarkTheme(bool value) {
    _getStorage.write(LOCAL_STORAGE_THEME_MODE, value);
  }

  @override
  String get locale => _getStorage.read(LOCAL_STORAGE_LOCALE) ?? 'en';

  @override
  set locale(String value) {
    _getStorage.write(LOCAL_STORAGE_LOCALE, value);
  }
}

const String LOCAL_STORAGE_THEME_MODE = 'theme_mode';
const String LOCAL_STORAGE_LOCALE = 'locale';
