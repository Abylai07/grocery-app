import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:abricoz_app/src/common/utils/shared_preference.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../app_styles/colors.dart';
import '../../constants.dart';

part 'show_notifications.dart';

class Notifications {
  static final Notifications _singleton = Notifications._internal();

  static final FlutterLocalNotificationsPlugin localNotifications =
      FlutterLocalNotificationsPlugin();

  Notifications._internal();

  factory Notifications() => _singleton;

  final messaging = FirebaseMessaging.instance;

  String _firebaseToken = '';

  String get firebaseToken => _firebaseToken;

  Future init(BuildContext context) async {
    final fcmToken = await messaging.getToken();

    if (fcmToken != null) {
      debugPrint("[FCM TOKEN] $fcmToken");
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

    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message?.data != null) {
        log(message!.data.toString(), name: 'Notification');
        handlePushToNavigate(context, message.data);
      }
    });

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
          "fcm_token": _firebaseToken.toString()
        });

        debugPrint('fcm send ${result.data}');
      }
    } catch (e) {
      debugPrint('fcm send error $e');
    }

    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    // iOS initialization
    DarwinInitializationSettings iosInitializationSettings =
        const DarwinInitializationSettings();
    InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: iosInitializationSettings,
    );

    localNotifications.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (details) async {
      log(details.payload.toString(), name: 'onNotificationPressed');
      handlePushToNavigate(context, details.payload != null ? jsonDecode(details.payload!) : {});
    });

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
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      log('onMessageOpenedApp ${message.data.toString()}',
          name: 'onMessageOpenedApp');
      handlePushToNavigate(context, message.data);
    });
  }
}

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

void handlePushToNavigate(BuildContext context, Map<String, dynamic>? data) {
  log(data.toString(), name: 'handlePushToNavigate');

  if (context.mounted) return;

    pushToScreen(
      context,);
}

pushToScreen(BuildContext context) {
 // AutoRouter.of(context).push(const InformationRoute());
}
