import 'package:built_collection/built_collection.dart';
import 'package:equatable/equatable.dart';
import 'package:familiarise/data/user_minimal.dart';

class Message extends Equatable {
  final DateTime createdAt;
  final UserMinimal senderUser;
  final String text;

  @override
  List<Object> get props => [createdAt, senderUser, text];

  static Message fromJson(Map<String, dynamic> jsonMap) {
    return Message(
      DateTime.parse(jsonMap['createdAt'] as String),
      UserMinimal.fromJson(jsonMap['senderUser'] as Map<String, dynamic>),
      jsonMap['text'] as String,
    );
  }

  const Message(this.createdAt, this.senderUser, this.text);

  Message copyWith({DateTime createdAt, UserMinimal senderUser, String text}) {
    return Message(
      createdAt ?? this.createdAt,
      senderUser ?? this.senderUser,
      text ?? this.text,
    );
  }
}

class MessageInbox extends Equatable {
  final BuiltList<Message> messages;

  @override
  List<Object> get props => [messages];

  static MessageInbox fromJson(Map<String, dynamic> jsonMap) {
    return MessageInbox(
      BuiltList.of(
        (jsonMap['messages'] as List<dynamic>).map(
          (dynamic message) =>
              Message.fromJson(message as Map<String, dynamic>),
        ),
      ),
    );
  }

  const MessageInbox(this.messages);
}

class MessageTemplate extends Equatable {
  final bool used;
  final String text;

  @override
  List<Object> get props => [used, text];

  static MessageTemplate fromJson(Map<String, dynamic> jsonMap) {
    return MessageTemplate(
      jsonMap['used'] as bool,
      jsonMap['text'] as String,
    );
  }

  const MessageTemplate(this.used, this.text);

  MessageTemplate copyWith({String text}) {
    return MessageTemplate(
      used ?? this.used,
      text ?? this.text,
    );
  }
}

class AvailableMessages extends Equatable {
  final BuiltList<MessageTemplate> messageTemplates;

  @override
  List<Object> get props => [messageTemplates];

  static AvailableMessages fromJson(Map<String, dynamic> jsonMap) {
    return AvailableMessages(
      BuiltList.of(
        (jsonMap['messageTemplates'] as List<dynamic>).map(
          (dynamic messageTemplate) =>
              MessageTemplate.fromJson(messageTemplate as Map<String, dynamic>),
        ),
      ),
    );
  }

  const AvailableMessages(this.messageTemplates);
}
