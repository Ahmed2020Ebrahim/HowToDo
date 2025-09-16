import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefHelper {
  // Private constructor
  SharedPrefHelper._privateConstructor();

  // The single instance
  static final SharedPrefHelper instance = SharedPrefHelper._privateConstructor();

  SharedPreferences? _prefs;

  // Init method to load preferences
  Future<void> init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  // Save a string
  Future<void> setString(String key, String value) async {
    await _prefs?.setString(key, value);
  }

  // Get a string
  String? getString(String key) {
    return _prefs?.getString(key);
  }

  // Save a bool
  Future<void> setBool(String key, bool value) async {
    await _prefs?.setBool(key, value);
  }

  // Get a bool
  bool getBool(String key, {bool defaultValue = false}) {
    return _prefs?.getBool(key) ?? defaultValue;
  }

  // Save an int
  Future<void> setInt(String key, int value) async {
    await _prefs?.setInt(key, value);
  }

  // Get an int
  int getInt(String key, {int defaultValue = 0}) {
    return _prefs?.getInt(key) ?? defaultValue;
  }

  // Save a double
  Future<void> setDouble(String key, double value) async {
    await _prefs?.setDouble(key, value);
  }

  // Get a double
  double getDouble(String key, {double defaultValue = 0.0}) {
    return _prefs?.getDouble(key) ?? defaultValue;
  }

  // Remove a key
  Future<void> remove(String key) async {
    await _prefs?.remove(key);
  }

  // Clear all
  Future<void> clear() async {
    await _prefs?.clear();
  }
}
