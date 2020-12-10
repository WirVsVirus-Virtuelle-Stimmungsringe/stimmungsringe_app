import 'dart:async';

import 'package:familiarise/config.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

enum MessageEvent {
  appStartedOnMessageClick,
  appResumedOnMessageClick,
  receivedMessageWhileInForeground,
}

class PushNotificationsManager {
  factory PushNotificationsManager() => _instance;

  PushNotificationsManager._();

  static final PushNotificationsManager _instance =
      PushNotificationsManager._();

  bool _initialized = false;

  Future<void> init() async {
    if (!_initialized) {
      await Firebase.initializeApp();
      final FirebaseMessaging messaging = FirebaseMessaging.instance;

      // For iOS request permission first.
      final notificationSettings = await messaging.requestPermission();

      if (notificationSettings.authorizationStatus !=
          AuthorizationStatus.authorized) {
        return;
      }

      _printToken();

      final RemoteMessage initialMessage = await messaging.getInitialMessage();

      if (initialMessage != null) {
        _onMessage(MessageEvent.appStartedOnMessageClick, initialMessage);
      }

      FirebaseMessaging.onMessage.listen((message) =>
          _onMessage(MessageEvent.receivedMessageWhileInForeground, message));
      FirebaseMessaging.onMessageOpenedApp.listen((message) =>
          _onMessage(MessageEvent.appResumedOnMessageClick, message));
      FirebaseMessaging.onBackgroundMessage(
          _firebaseMessagingBackgroundHandler);

      _initialized = true;
    }
  }

  void _onMessage(MessageEvent event, RemoteMessage message) {
    print('Got a message via: $event');
    print('Message data: ${message.data}');

    if (message.notification != null) {
      print(
          'Message also contained a notification, title: ${message.notification.title}, body: ${message.notification.body}');
    }
  }

  // For testing purposes print the Firebase Messaging token
  Future<void> _printToken() async {
    if (!Config().debug) {
      return;
    }

    print(
        "FirebaseMessaging token: ${await FirebaseMessaging.instance.getToken()}");
  }
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();

  print('Got a message whilst in the background/stopped!');
  print('Message data: ${message.data}');

  if (message.notification != null) {
    print(
        'Message also contained a notification, title: ${message.notification.title}, body: ${message.notification.body}');
  }
}
