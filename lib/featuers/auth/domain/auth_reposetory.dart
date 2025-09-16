import 'package:how_to_do/utils/helpers/shared_pref_helper.dart';

class AuthRepository {
  static const _key = "isLoggedIn";
  static const _isFirstRun = "isFirstRun";

  Future<bool> isFirstRun() async {
    final prefs = SharedPrefHelper.instance;
    return prefs.getBool(_isFirstRun, defaultValue: true);
  }

  //change first run
  Future<void> setFirstRun(bool value) async {
    final prefs = SharedPrefHelper.instance;
    await prefs.setBool(_isFirstRun, value);
  }

  Future<bool> isLoggedIn() async {
    final prefs = SharedPrefHelper.instance;
    return prefs.getBool(_key);
  }

  Future<void> login() async {
    final prefs = SharedPrefHelper.instance;
    await prefs.setBool(_key, true);
  }

  Future<void> logout() async {
    final prefs = SharedPrefHelper.instance;
    await prefs.remove(_key);
  }
}
