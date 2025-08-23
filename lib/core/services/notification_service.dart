import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';

class NotificationService {
  bool _isInitialized = false;
  static final NotificationService _notificationService =
      NotificationService._internal();
  factory NotificationService() {
    return _notificationService;
  }
  NotificationService._internal();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    if (_isInitialized) {
      return;
    }
    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('@drawable/app_icon');

    const DarwinInitializationSettings iosInitializationSettings =
        DarwinInitializationSettings(
          requestAlertPermission: true,
          requestBadgePermission: true,
          requestSoundPermission: true,
        );

    const InitializationSettings initializationSettings =
        InitializationSettings(
          android: androidInitializationSettings,
          iOS: iosInitializationSettings,
        );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
    _isInitialized = true;
  }

  NotificationDetails notificationDetails() {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
          'main_channel',
          'Main Channel',
          channelDescription: 'Main channel notifications',
          importance: Importance.max,
          priority: Priority.high,
        );
    const DarwinNotificationDetails isoNotificationDetails =
        DarwinNotificationDetails();
    NotificationDetails notificationDetails = const NotificationDetails(
      android: androidNotificationDetails,
      iOS: isoNotificationDetails,
    );
    return notificationDetails;
  }

  Future<void> showNotification(int id, String title, String body) async {
    await flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      notificationDetails(),
    );
  }

  Future<void> requestNotificationPermission() async {
    if (await Permission.notification.isDenied) {
      await Permission.notification.request();
    }
  }
}
