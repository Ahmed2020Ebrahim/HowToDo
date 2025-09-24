import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import '../../../data/user_model.dart';
import '../../../../../utils/exceptions/firebase_exception.dart';

class FirebaseAuthServices {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  // Register a new user
  static Future<UserModel> registerWithEmailAndPassword(String email, String password) async {
    try {
      final userCreds = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return _toUserModel(userCreds.user)!;
    } on FirebaseAuthException catch (e) {
      throw FirebaseExceptionHandler(e.code).message;
    } on FirebaseException catch (e) {
      throw FirebaseExceptionHandler(e.code).message;
    } on FormatException catch (e) {
      throw FirebaseExceptionHandler(e.message).message;
    } on PlatformException catch (e) {
      throw FirebaseExceptionHandler(e.code).message;
    } catch (e) {
      throw FirebaseExceptionHandler("some unknown happend!").message;
    }
  }

  // [EmailAuthentication]   -   sign in
  static Future<UserModel> loginWithEmailAndPassword(String email, String password) async {
    try {
      final userCreds = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return _toUserModel(userCreds.user)!;
    } on FirebaseAuthException catch (e) {
      throw FirebaseExceptionHandler(e.code).message;
    } on FirebaseException catch (e) {
      throw FirebaseExceptionHandler(e.code).message;
    } on FormatException catch (e) {
      throw FirebaseExceptionHandler(e.message).message;
    } on PlatformException catch (e) {
      throw FirebaseExceptionHandler(e.code).message;
    } catch (e) {
      throw FirebaseExceptionHandler("some unknown happend!").message;
    }
  }

  // [USER LOGOUT]  - logout
  static Future<void> logOut() async {
    try {
      await _auth.signOut();
    } on FirebaseAuthException catch (e) {
      throw FirebaseExceptionHandler(e.code).message;
    } on FirebaseException catch (e) {
      throw FirebaseExceptionHandler(e.code).message;
    } on FormatException catch (e) {
      throw FirebaseExceptionHandler(e.message).message;
    } on PlatformException catch (e) {
      throw FirebaseExceptionHandler(e.code).message;
    } catch (e) {
      throw FirebaseExceptionHandler("some unknown happend!").message;
    }
  }

  // Check current
  static UserModel? getCurrentUser() => _toUserModel(_auth.currentUser);

  //is auth
  static bool isAuthenticated() => _auth.currentUser != null;

  // [convert to user model]
  static UserModel? _toUserModel(User? user) {
    if (user == null) return null;
    return UserModel(uid: user.uid, email: user.email ?? '', name: user.displayName ?? '');
  }
}
