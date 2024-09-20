part of 'notifications.dart';

Future<void> showNotification(String title, String body) async {
  final androidPlatformChannelSpecifics = AndroidNotificationDetails(
    channel.id,
    channel.name,
    channelDescription: channel.description,
    importance: Importance.high,
    priority: Priority.high,
    styleInformation: BigTextStyleInformation(body),
    icon: '@drawable/notification',
    colorized: true,
    color: AppColors.main,
  );
  final platformChannelSpecifics = NotificationDetails(
    android: androidPlatformChannelSpecifics,
  );
  await Notifications.localNotifications.show(
    0,
    title,
    body,
    platformChannelSpecifics,
  );
}
