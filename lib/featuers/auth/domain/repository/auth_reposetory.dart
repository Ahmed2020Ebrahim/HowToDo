import 'dart:developer';

import 'package:how_to_do/featuers/auth/data/user_model.dart';
import 'package:how_to_do/featuers/auth/domain/services/auth_services/firebase_auth_services.dart';
import 'package:how_to_do/featuers/auth/domain/services/auth_services/firestore_auth_services.dart';
import 'package:how_to_do/featuers/auth/domain/services/auth_services/local_storage_auth_services.dart';

class AuthRepository {
  //register
  static Future<UserModel> register(UserModel user, String password) async {
    try {
      UserModel result = await FirebaseAuthServices.registerWithEmailAndPassword(
        user.email,
        password,
      );
      log('from auth_reposetory/register()-> User registered uid: ${result.uid}');

      //set current user
      CurrentUser.user = UserModel(uid: result.uid, email: user.email, name: user.name);
      //save user to firestore
      await FirestoreAuthServices.addUser(CurrentUser.user!.toJson());
      //save user to local storage
      await LocalStorageAuthServices.saveUserToLocalStorage(CurrentUser.user!);
      //save logged in status to local storage
      await LocalStorageAuthServices.setLoggedInToLocalStorage();
      //init current user
      await CurrentUser.init();
      //return current user
      return CurrentUser.user!;
    } catch (e) {
      rethrow;
    }
  }

  //login
  static Future<UserModel> login(String email, String password) async {
    try {
      //login user
      UserModel user = await FirebaseAuthServices.loginWithEmailAndPassword(email, password);
      //fetch user data from firestore
      UserModel userData = await FirestoreAuthServices.getUserById(user.uid!);
      //set current user
      CurrentUser.user = UserModel(email: email, name: userData.name, uid: user.uid);
      //save user to local storage
      await LocalStorageAuthServices.saveUserToLocalStorage(CurrentUser.user!);
      //save logged in status to local storage
      await LocalStorageAuthServices.setLoggedInToLocalStorage();
      //init current user
      await CurrentUser.init();
      //return current user
      return user;
    } catch (e) {
      rethrow;
    }
  }

  //get current user
  static UserModel? currentUser() {
    return FirebaseAuthServices.getCurrentUser();
  }

  //isAuthenticated
  static bool isAuthenticated() {
    return FirebaseAuthServices.isAuthenticated();
  }

  //logout
  static Future<void> logout() async {
    try {
      //clear current user
      CurrentUser.user = null;
      //remove user from local storage
      await LocalStorageAuthServices.removeUserFromLocalStorage();
      //logout from firebase
      await FirebaseAuthServices.logOut();
      //remove user from local storage
      await LocalStorageAuthServices.removeUserFromLocalStorage();
      //clear logged in status from local storage
      await LocalStorageAuthServices.setLoggedOutToLocalStorage();
    } catch (e) {
      rethrow;
    }
  }
}
