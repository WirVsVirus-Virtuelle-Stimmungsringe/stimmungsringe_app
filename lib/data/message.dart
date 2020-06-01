import 'package:built_collection/built_collection.dart';
import 'package:equatable/equatable.dart';

class Message extends Equatable {
  final String text;

  @override
  List<Object> get props => [text];

  static Message fromJson(Map<String, dynamic> jsonMap) {
    return Message(
      jsonMap['text'] as String,
    );
  }

  const Message(this.text);

  Message copyWith({String text}) {
    return Message(
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
          (dynamic message) => Message.fromJson(message),
        ),
      ),
    );
  }

  const MessageInbox(this.messages);
}
