import 'dart:convert';

import 'package:familiarise/config.dart';
import 'package:familiarise/data/message.dart';
import 'package:familiarise/repositories/chaos_monkey.dart';
import 'package:familiarise/session.dart';
import 'package:familiarise/utils/response.dart';
import 'package:http/http.dart' as http;

class MessageRepository {
  static final MessageRepository _singleton = MessageRepository._internal();

  factory MessageRepository() {
    return _singleton;
  }

  MessageRepository._internal();

  Future<MessageInbox> loadInbox() async {
    final String url = '${Config().backendUrl}/message/inbox';

    final http.Response response = await http.get(
      url,
      headers: {'X-User-ID': currentUserId},
    );

    // note: fetching inbox is subject to race condition, e.g. if user leaves group
    assert(response.statusCode == 200);

    final MessageInbox inbox =
        MessageInbox.fromJson(decodeResponseBytesToJson(response.bodyBytes));

    await ChaosMonkey.delayAsync();
    return inbox;
  }

  Future<AvailableMessages> loadAvailableMessages(String recipientId) async {
    final String url =
        '${Config().backendUrl}/message/available-messages/$recipientId';

    final http.Response response = await http.get(
      url,
      headers: {'X-User-ID': currentUserId},
    );

    assert(response.statusCode == 200);

    final AvailableMessages availableMessages = AvailableMessages.fromJson(
        decodeResponseBytesToJson(response.bodyBytes));

    await ChaosMonkey.delayAsync();
    return availableMessages;
  }

  Future<AvailableMessages> sendMessage(String recipientId, String text) async {
    final String url = '${Config().backendUrl}/message/send/$recipientId';

    final http.Response response = await http.post(
      url,
      headers: {'Content-Type': 'application/json', 'X-User-ID': currentUserId},
      body: json.encode({'text': text}),
    );

    assert(response.statusCode == 200);

    final AvailableMessages availableMessages = AvailableMessages.fromJson(
        decodeResponseBytesToJson(response.bodyBytes));

    await ChaosMonkey.delayAsync();
    return availableMessages;
  }
}
