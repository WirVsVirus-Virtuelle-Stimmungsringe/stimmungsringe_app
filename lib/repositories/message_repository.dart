import 'dart:convert';

import 'package:familiarise/config.dart';
import 'package:familiarise/data/message.dart';
import 'package:familiarise/repositories/chaos_monkey.dart' as chaos_monkey;
import 'package:familiarise/session.dart';
import 'package:familiarise/utils/api_headers.dart';
import 'package:familiarise/utils/response.dart';
import 'package:http/http.dart' as http;

class MessageRepository {
  static final MessageRepository _singleton = MessageRepository._internal();

  factory MessageRepository() {
    return _singleton;
  }

  MessageRepository._internal();

  Future<MessageInbox> loadInbox() async {
    final Uri url = Uri.parse('${Config().backendUrl}/message/inbox');

    final http.Response response = await http.get(
      url,
      headers: authenticated(currentUserId),
    );

    // note: fetching inbox is subject to race condition, e.g. if user leaves group
    assert(response.statusCode == 200);

    final MessageInbox inbox =
        MessageInbox.fromJson(decodeResponseBytesToJson(response.bodyBytes));

    await chaos_monkey.delayAsync();
    return inbox;
  }

  Future<AvailableMessages> loadAvailableMessages(String recipientId) async {
    final Uri url = Uri.parse(
      '${Config().backendUrl}/message/available-messages/$recipientId',
    );

    final http.Response response = await http.get(
      url,
      headers: authenticated(currentUserId),
    );

    assert(response.statusCode == 200);

    final AvailableMessages availableMessages = AvailableMessages.fromJson(
      decodeResponseBytesToJson(response.bodyBytes),
    );

    await chaos_monkey.delayAsync();
    return availableMessages;
  }

  Future<AvailableMessages> sendMessage(String recipientId, String text) async {
    final Uri url =
        Uri.parse('${Config().backendUrl}/message/send/$recipientId');

    final http.Response response = await http.post(
      url,
      headers: {
        ...authenticated(currentUserId),
        'Content-Type': 'application/json',
      },
      body: json.encode({'text': text}),
    );

    assert(response.statusCode == 200);

    final AvailableMessages availableMessages = AvailableMessages.fromJson(
      decodeResponseBytesToJson(response.bodyBytes),
    );

    await chaos_monkey.delayAsync();
    return availableMessages;
  }
}
