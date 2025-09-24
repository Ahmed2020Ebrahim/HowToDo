import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';
import 'package:how_to_do/featuers/home/model/task_model.dart';

import '../../../utils/helpers/hive_helper.dart';
import '../domain/services/auth_services/local_storage_auth_services.dart';

class UserModel {
  final String? uid;
  final String email;
  final String name;

  //empty user
  static UserModel empty() => UserModel(uid: "", email: "", name: '');

  UserModel({this.uid, required this.email, required this.name});

  Map<String, dynamic> toJson() {
    return {'uid': uid, 'email': email, 'name': name};
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(uid: json['uid'], email: json['email'], name: json['name']);
  }

  //usermodel creator from firebase snabshot documents
  factory UserModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data();
      return UserModel(uid: document.id, name: data!["name"] ?? "", email: data["email"] ?? "");
    } else {
      return empty();
    }
  }
}

class CurrentUser {
  CurrentUser._();

  static UserModel? user;

  static Future<void> init() async {
    user = await LocalStorageAuthServices.getUserFromLocalStorage();
    //open hive box for user if needed
    if (user != null && user!.uid != null && user!.uid!.isNotEmpty) {
      if (!Hive.isBoxOpen(user!.uid!)) {
        await Hive.openBox<Task>(user!.uid!);
      }
    }
  }
}
