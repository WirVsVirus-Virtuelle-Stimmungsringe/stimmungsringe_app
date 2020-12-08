import 'dart:async';
import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;

class PushNotificationsManager {
  PushNotificationsManager._();

  factory PushNotificationsManager() => _instance;

  static final PushNotificationsManager _instance =
      PushNotificationsManager._();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  bool _initialized = false;
  String _token;

  Future<void> init() async {
    if (!_initialized) {
      // For iOS request permission first.
      _firebaseMessaging.requestNotificationPermissions();
      _firebaseMessaging.configure(
        onMessage: (Map<String, dynamic> message) async {
          print("onMessage: $message");
        },
        onBackgroundMessage: myBackgroundMessageHandler,
        onLaunch: (Map<String, dynamic> message) async {
          print("onLaunch: $message");
        },
        onResume: (Map<String, dynamic> message) async {
          print("onResume: $message");
        },
      );

      // For testing purposes print the Firebase Messaging token
      _token = await _firebaseMessaging.getToken();
      print("FirebaseMessaging token: $_token");

      _initialized = true;
    }
  }

  Future<void> sendAndRetrieveMessage() async {
    const String serverToken = 'TODO';

    await Future<void>.delayed(const Duration(seconds: 2));
    final body = jsonEncode(<String, dynamic>{
      'notification': <String, dynamic>{
        'body': 'this is a body',
        'title': 'this is a title'
      },
      'priority': 'high',
      'data': <String, dynamic>{
        'click_action': 'FLUTTER_NOTIFICATION_CLICK',
        'id': '1',
        'status': 'done'
      },
      'to': _token,
    });
    final response = await http.post(
      'https://fcm.googleapis.com/fcm/send',
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key=$serverToken',
      },
      body: body,
    );

    print(body);

    print('Sent notification with statusCode: ${response.statusCode}');
  }
}

Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) async {
  if (message.containsKey('data')) {
    // Handle data message
    final dynamic data = message['data'];
  }

  if (message.containsKey('notification')) {
    // Handle notification message
    final dynamic notification = message['notification'];
  }

  // Or do other work.
}
