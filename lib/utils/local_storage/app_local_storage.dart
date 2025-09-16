import 'package:get_storage/get_storage.dart';

class AppLocalStorage {
  static final AppLocalStorage _instance = AppLocalStorage._internal();

  factory AppLocalStorage() {
    return _instance;
  }
  AppLocalStorage._internal();

  final _storage = GetStorage();

//! ---> save data
  Future<void> saveData<T>(String key, T value) async {
    await _storage.write(key, value);
  }

//! ---> read data
  T? readData<T>(String key) {
    return _storage.read<T>(key);
  }

//! ---> remove data
  Future<void> removeData(String key) async {
    await _storage.remove(key);
  }

//! ---> clear all data
  Future<void> clearAll() async {
    await _storage.erase();
  }
}
