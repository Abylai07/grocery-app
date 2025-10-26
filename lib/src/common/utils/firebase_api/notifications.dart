import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:grocery_app/src/common/utils/app_router/app_router.dart';
import 'package:grocery_app/src/common/utils/shared_preference.dart';
import 'package:grocery_app/src/presentation/view/profile/screens/orders/order_detail_screen.dart';
import 'package:auto_route/auto_route.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../../data/models/user/push_data_model.dart';
import '../../../presentation/view/profile/bloc/order/active_orders_cubit.dart';
import '../../app_styles/colors.dart';
import '../../constants.dart';
import '../../enums.dart';

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

  Future  init(BuildContext context) async {
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
          "fcm_token": _firebaseToken.toString(),
          "fcm_token_type_id": 1,
        });

        debugPrint('fcm send ${result.data}');
      }
    } catch (e) {
      debugPrint('fcm send error $e');
    }

    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings('@mipmap/ic_launcher');

    DarwinInitializationSettings iosInitializationSettings =
        const DarwinInitializationSettings();
    InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: iosInitializationSettings,
    );

    localNotifications.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (details) async {
      log(details.payload.toString(), name: 'onNotificationPressed');
      handlePushToNavigate(
          context, details.payload != null ? jsonDecode(details.payload!) : {});
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


  if (data == null) return;

  pushToScreen(
    context,
    data: PushDataModel.fromJson(data),
  );
}

pushToScreen(BuildContext context, {required PushDataModel data}) {
  OrderStatus status = getStatusById(data.orderStatusId);
  if(data.orderId > 0) {
    context.read<ActiveOrdersCubit>().fetchActiveOrders();
    AutoRouter.of(context).push(OrderDetailRoute(orderId: data.orderId));
  }
}
