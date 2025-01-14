import 'package:camera/camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'Widgets/Home/ThemeNotifier.dart';
import 'SolarIQ.dart';

List<CameraDescription>? cameras;
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  cameras = await availableCameras();

  // Initialize notifications
  await _initializeNotifications();

  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeNotifier(),
      child: const SolarIQ(),
    ),
  );
}

Future<void> _initializeNotifications() async {
  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
  const initializationSettings = InitializationSettings(android: androidSettings);

  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse: (NotificationResponse response) {
      debugPrint('Notification clicked with payload: ${response.payload}');
    },
  ).then((_) {
    debugPrint('Notification plugin initialized');
  }).catchError((error) {
    debugPrint('Error initializing notification plugin: $error');
  });
}

Future<void> sendNotification(String title, String body, {String? payload}) async {
  const androidDetails = AndroidNotificationDetails(
    'default_channel_id',
    'Default Notifications',
    channelDescription: 'Default notification channel for app events',
    importance: Importance.high,
    priority: Priority.high,
  );
  const notificationDetails = NotificationDetails(android: androidDetails);

  await flutterLocalNotificationsPlugin.show(
    0, // Notification ID
    title,
    body,
    notificationDetails,
    payload: payload,
  );
}
