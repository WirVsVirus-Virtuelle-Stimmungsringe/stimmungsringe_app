import 'package:equatable/equatable.dart';

class Suggestion extends Equatable {
  final String text;

  @override
  List<Object> get props => [text];

  static Suggestion fromJson(Map<String, dynamic> jsonMap) {
    return Suggestion(
      jsonMap['text'] as String /*!*/,
    );
  }

  const Suggestion(this.text);
}
