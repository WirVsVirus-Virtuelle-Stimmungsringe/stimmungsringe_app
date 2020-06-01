import 'dart:convert';

import 'package:familiarise/config.dart';
import 'package:familiarise/data/message.dart';
import 'package:familiarise/repositories/chaos_monkey.dart';
import 'package:familiarise/session.dart';
import 'package:http/http.dart' as http;

class MessageRepository {
  static final MessageRepository _singleton = MessageRepository._internal();

  factory MessageRepository() {
    return _singleton;
  }

  MessageRepository._internal();

  Future<MessageInbox> loadInbox() async {
    final String url = '${Config().backendUrl}/inbox';

    final http.Response response = await http.get(
      url,
      headers: {'X-User-ID': currentUserId},
    );

    assert(response.statusCode == 200);

    final MessageInbox inbox = MessageInbox.fromJson(
        json.decode(response.body) as Map<String, dynamic>);

    await ChaosMonkey.delayAsync();
    return inbox;
  }
}
