import 'dart:convert';
import 'package:how_to_do/featuers/auth/data/user_model.dart';
import '../../../../../utils/helpers/shared_pref_helper.dart';

class LocalStorageAuthServices {
  static const _isLoggedIn = "isLoggedIn";
  static const _isLocalizationSet = "isLocalizationSet";
  static const _userKey = "user";

  //check if it is localization done
  static Future<bool> isLocalizationDone() async {
    final prefs = SharedPrefHelper.instance;
    return prefs.getBool(_isLocalizationSet, defaultValue: false);
  }

  //change localization set
  static Future<void> setLocalizationToLocalStorage(bool value) async {
    final prefs = SharedPrefHelper.instance;
    await prefs.setBool(_isLocalizationSet, value);
  }

  //check if user is logged in
  static Future<bool> isLoggedInToLocalStorage() async {
    final prefs = SharedPrefHelper.instance;
    return prefs.getBool(_isLoggedIn);
  }

  //set loggedin status
  static Future<void> setLoggedInToLocalStorage() async {
    final prefs = SharedPrefHelper.instance;
    await prefs.setBool(_isLoggedIn, true);
  }

  //set logged out status
  static Future<void> setLoggedOutToLocalStorage() async {
    final prefs = SharedPrefHelper.instance;
    await prefs.remove(_isLoggedIn);
  }

  //save user to local storage
  static Future<void> saveUserToLocalStorage(UserModel user) async {
    final prefs = SharedPrefHelper.instance;
    await prefs.setString(_userKey, jsonEncode(user.toJson()));
  }

  //remove user from local storage
  static Future<void> removeUserFromLocalStorage() async {
    final prefs = SharedPrefHelper.instance;
    await prefs.remove(_userKey);
  }

  //get user from local storage
  static Future<UserModel?> getUserFromLocalStorage() async {
    final prefs = SharedPrefHelper.instance;
    UserModel? user;
    if (prefs.getString(_userKey) != null) {
      user = UserModel.fromJson(jsonDecode(prefs.getString("user")!));
      return user;
    } else {
      return null;
    }
  }
}
