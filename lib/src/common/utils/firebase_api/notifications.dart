import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:abricoz_app/src/common/utils/shared_preference.dart';
import 'package:device_info_plus/device_info_plus.dart';
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

  Future<String?> getId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      var iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor; // unique ID on iOS
    } else if (Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.id; // unique ID on Android
    } else {
      return null;
    }
  }

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

    try {
      String? token = SharedPrefs().getAccessToken();
      if (token != null) {
        String? deviceId = await getId();

        final dio = Dio(
          BaseOptions(
            headers: {'Authorization': 'Bearer $token'},
            baseUrl: host,
            contentType: Headers.jsonContentType,
          ),
        );


        final result = await dio.post('user-device/store', data: {
          "device_id": deviceId,
          "fcm_token":  _firebaseToken.toString()
        });
        print('fcm send ${result.data}');
      }
    } catch (e) {
      print('fcm send error $e');
    }

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
