import 'package:hive_flutter/hive_flutter.dart';

class HiveHelper {
  //private constructor
  HiveHelper._privateConstructor();

  //the single instance
  static final HiveHelper instance = HiveHelper._privateConstructor();

  bool _isInitialized = false;

  ///initialize Hive
  Future<void> init() async {
    if (_isInitialized) return;

    await Hive.initFlutter(); // بديل path_provider

    _isInitialized = true;
  }

  ///open a box
  Future<Box> openBox(String boxName) async {
    if (!_isInitialized) {
      throw Exception("Hive is not initialized. Call init() first.");
    }
    return await Hive.openBox(boxName);
  }

  ///put value with custom key
  Future<void> put(String boxName, String key, dynamic value) async {
    var box = await openBox(boxName);
    await box.put(key, value);
  }

  ///get value by key
  T? get<T>(String boxName, String key, {T? defaultValue}) {
    var box = Hive.box(boxName);
    return box.get(key, defaultValue: defaultValue);
  }

  ///add value with auto-incremented key
  Future<int> add(String boxName, dynamic value) async {
    var box = await openBox(boxName);
    return await box.add(value); // بيرجع index
  }

  ///get value by index
  T? getAt<T>(String boxName, int index) {
    var box = Hive.box(boxName);
    return box.getAt(index);
  }

  ///get all non-null values
  List<dynamic> getAllValuesNonNull(String boxName) {
    var box = Hive.box(boxName);
    return box.values.where((e) => e != null).toList();
  }

  ///delete value by key
  Future<void> delete(String boxName, String key) async {
    var box = Hive.box(boxName);
    await box.delete(key);
  }

  ///delete value by index
  Future<void> deleteAt(String boxName, int index) async {
    var box = Hive.box(boxName);
    await box.deleteAt(index);
  }

  ///get all keys
  Iterable<dynamic> getAllKeys(String boxName) {
    var box = Hive.box(boxName);
    return box.keys;
  }

  ///get all values
  Iterable<dynamic> getAllValues(String boxName) {
    var box = Hive.box(boxName);
    return box.values;
  }

  ///clear box
  Future<void> clear(String boxName) async {
    var box = Hive.box(boxName);
    await box.clear();
  }

  ///close specific box
  Future<void> closeBox(String boxName) async {
    var box = Hive.box(boxName);
    await box.close();
  }

  ///close all Hive
  Future<void> closeHive() async {
    await Hive.close();
    _isInitialized = false;
  }
}
