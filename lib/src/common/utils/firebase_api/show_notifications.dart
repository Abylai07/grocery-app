part of 'notifications.dart';

Future<void> showNotification(
  String title,
  String body, {
  Map<String, dynamic> payload = const {},
}) async {
  log("Payload of notification -->  $payload");
  final androidPlatformChannelSpecifics = AndroidNotificationDetails(
    channel.id,
    channel.name,
    channelDescription: channel.description,
    importance: Importance.max,
    priority: Priority.high,
    styleInformation: BigTextStyleInformation(body),
    icon: '@drawable/notification',
    colorized: true,
    color: AppColors.main2,
  );
  final platformChannelSpecifics = NotificationDetails(
    android: androidPlatformChannelSpecifics,
  );
  await Notifications.localNotifications.show(
    0,
    title,
    body,
    platformChannelSpecifics,
    payload: jsonEncode(payload),
  );
}

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
    payload: data.data,
  );
}
