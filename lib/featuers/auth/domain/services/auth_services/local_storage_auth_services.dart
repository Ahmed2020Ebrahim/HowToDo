import 'dart:convert';
import 'package:how_to_do/featuers/auth/data/user_model.dart';

import '../../../../../utils/helpers/shared_pref_helper.dart';

class LocalStorageAuthServices {
  static const _isLoggedIn = "isLoggedIn";
  static const _isLocalizationSet = "isLocalizationSet";
  static const _userKey = "user";

  //Todo : create instance when using shared_preferences
  static final prefs = SharedPrefHelper.instance;

  //check if it is localization done
  static Future<bool> isLocalizationDone() async {
    return prefs.getBool(_isLocalizationSet, defaultValue: false);
  }

  //change localization set
  static Future<void> setLocalizationToLocalStorage(bool value) async {
    await prefs.setBool(_isLocalizationSet, value);
  }

  //check if user is logged in
  static Future<bool> isLoggedInToLocalStorage() async {
    return prefs.getBool(_isLoggedIn);
  }

  //set loggedin status
  static Future<void> setLoggedInToLocalStorage() async {
    await prefs.setBool(_isLoggedIn, true);
  }

  //set logged out status
  static Future<void> setLoggedOutToLocalStorage() async {
    await prefs.remove(_isLoggedIn);
  }

  //save user to local storage
  static Future<void> saveUserToLocalStorage(UserModel user) async {
    await prefs.setString(_userKey, jsonEncode(user.toJson()));
  }

  //remove user from local storage
  static Future<void> removeUserFromLocalStorage() async {
    await prefs.remove(_userKey);
  }

  //get user from local storage
  static Future<UserModel?> getUserFromLocalStorage() async {
    UserModel? user;
    final data = await prefs.getString(_userKey);
    if (data != null) {
      user = UserModel.fromJson(jsonDecode(data));
      return user;
    } else {
      return null;
    }
  }
}
