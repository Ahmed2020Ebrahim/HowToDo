import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:how_to_do/utils/constants/shared_constants.dart';
import 'package:how_to_do/utils/helpers/shared_pref_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../firebase_options.dart';
import 'flutter_local_notification_services.dart';

class FirebaseNotificationService {
  static final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  final flutterLocalNotificationService = FlutterLocalNotificationService();

  //To be notified whenever the token is updated
  static void onTokenChanged() {
    _messaging.onTokenRefresh
        .listen((fcmToken) async {
          log(fcmToken, name: "FCM token");
          debugPrint("token has been refreshed: $fcmToken");
          // var prefs = await SharedPreferences.getInstance();
          //encypt shared pref
          var prefs = SharedPrefHelper.instance;
          await prefs.setString(SharedConstants.FCMKey, fcmToken).onError((error, stackTrace) {
            log(error.toString());
          });
        })
        .onError((err) {
          // Error getting token.
        });
  }

  // request permission must be done on ios and web
  static Future<void> requestPermission() async {
    final NotificationSettings settings = await _messaging.requestPermission(announcement: true);
    //Calling this method updates these options to allow customizing notification
    // presentation behavior whilst the application is in the foreground.
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );
    //settings.authorizationStatus
    debugPrint('User granted permission: ${settings.authorizationStatus}');
  }

  void handleForegroundNotifications() async {
    // when the app is foreground and on focus status
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      log(
        'Got a message whilst in the foreground! Message data: ${message.toMap()}',
        name: "onMessage",
      );
      if (message.notification != null) {
        flutterLocalNotificationService.showFirebaseNotification(message);
        debugPrint('Message also contained a notification: ${message.notification?.title}');
      }
    });
    // whe click on the message
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      log(
        "onMessageOpenedApp ${message.notification}\n${message.toMap()}",
        name: "onMessageOpenedApp",
      );
    });

    final message = await FirebaseMessaging.instance.getInitialMessage();
    log(
      "getInitialMessage ${message?.notification}\n${message?.toMap()}",
      name: "getInitialMessage",
    );
    if (message != null) {}
  }

  void handleBackgroundNotifications() {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  static void checkTokenChanging() async {
    var prefs = await SharedPreferences.getInstance();

    final String? currentFCMToken = prefs.getString(SharedConstants.FCMKey);
    final fcmToken = await FirebaseMessaging.instance.getToken();
    if (fcmToken != null) {
      log(fcmToken, name: "FCM token");
      if (currentFCMToken == null) {
        await prefs.setString(SharedConstants.FCMKey, fcmToken);
      }
      // if token changes then update token
      else if (currentFCMToken != fcmToken) {
        debugPrint("token has been changed $fcmToken");
        await prefs.setString(SharedConstants.FCMKey, fcmToken);
        // update on the server side
      }
    }
  }

  Future<void> setUp() async {
    handleBackgroundNotifications();
    await requestPermission();

    await flutterLocalNotificationService.setupFlutterNotifications();
    handleForegroundNotifications();
    checkTokenChanging();
    onTokenChanged();
  }
}

//When using Flutter version 3.3.0 or higher,
// the message handler must be annotated with @pragma('vm:entry-point')
// right above the function declaration (
// otherwise it may be removed during tree shaking for release mode)
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  final flutterLocalNotificationService = FlutterLocalNotificationService();
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call initializeApp before using other Firebase services.
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await flutterLocalNotificationService.setupFlutterNotifications();
  // flutterLocalNotificationService.showFirebaseNotification(message);
  debugPrint("Handling a background message: ${message.messageId}");
}
