import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../app_styles/colors.dart';
import '../../constants.dart';

part 'show_notifications.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'abricoz', // id
  'Abricoz', // title
  description:
      'This channel is used for important notifications.', // description
  importance: Importance.high,
);

Future<void> _backgroundMessageHandler(RemoteMessage data) async {
  log("background message ${data.notification?.title} -- ${data.notification?.body}");
  // showNotification(
  //   data.notification?.title ?? '',
  //   data.notification?.body ?? '',
  //   payload: '',
  // );
}

void _foregroundMessageHandler(RemoteMessage data) async {
  log("foreground message ${data.notification?.title} -- ${data.notification?.body}");
  showNotification(
    data.notification?.title ?? '',
    data.notification?.body ?? '',
  );
}

class Notifications {
  static final Notifications _singleton = Notifications._internal();

  static final FlutterLocalNotificationsPlugin localNotifications =
      FlutterLocalNotificationsPlugin();

  Notifications._internal();

  factory Notifications() => _singleton;

  final messaging = FirebaseMessaging.instance;

  String _firebaseToken = '';

  String get firebaseToken => _firebaseToken;

  Future init() async {
    final fcmToken = await messaging.getToken();

    if (fcmToken != null) {
      print("[FCM TOKEN] $fcmToken");
      _firebaseToken = fcmToken;
    }

    await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: true,
      provisional: false,
      sound: true,
    );
    // try {
    //   if (token != null) {
    //     final dio = Dio(
    //       BaseOptions(
    //         headers: {'Authorization': 'Bearer $token'},
    //         baseUrl: host,
    //         contentType: Headers.jsonContentType,
    //       ),
    //     );
    //
    //     final result = await dio.post('user/save-fcm-token/', data: {
    //       'fcm_token': _firebaseToken.toString(),
    //     });
    //     print('fcm send ${result.statusCode}');
    //   }
    // } catch (e) {
    //   print('fcm send error $e');
    // }

    await messaging.setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );

    await localNotifications
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    FirebaseMessaging.onBackgroundMessage(_backgroundMessageHandler);
    if (!Platform.isIOS) {
      FirebaseMessaging.onMessage.listen(_foregroundMessageHandler);
    }
    FirebaseMessaging.onMessageOpenedApp.listen(_foregroundMessageHandler);
  }
}
