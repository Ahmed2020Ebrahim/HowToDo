import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:how_to_do/featuers/auth/data/user_model.dart';

import '../../../../../utils/exceptions/firebase_exception.dart';

class FirestoreAuthServices {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Add a new user to Firestore
  static Future<void> addUser(Map<String, dynamic> userData) async {
    try {
      await _firestore.collection('users').add(userData);
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

  // Fetch user data by UID
  static Future<UserModel> getUserById(String uid) async {
    try {
      final querySnapshot = await _firestore.collection('users').where('uid', isEqualTo: uid).get();
      if (querySnapshot.docs.isNotEmpty) {
        return UserModel.fromSnapshot(querySnapshot.docs.first);
      } else {
        throw Exception('User not found');
      }
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
}
