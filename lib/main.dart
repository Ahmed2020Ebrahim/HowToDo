import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:how_to_do/app.dart';
import 'package:how_to_do/featuers/auth/data/user_model.dart';
import 'firebase_options.dart';
import 'utils/helpers/hive_helper.dart';
import 'utils/helpers/shared_pref_helper.dart';

void main() async {
  //Todo : Ensure widget binding
  WidgetsFlutterBinding.ensureInitialized();

  //Todo : firebase intialize
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  //Todo : Initialize shared preferences
  await SharedPrefHelper.instance.init();

  //Todo : Initialize Hive & register adapters
  await HiveHelper.instance.init();

  //Todo : Lock the app in portrait only
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  //Todo : initial current user if exists in shared prefs & open hive box for user tasks
  await CurrentUser.init();

  //Todo : run the app
  runApp(const App());
}
