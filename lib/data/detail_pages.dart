import 'package:stimmungsringeapp/data/freezed_classes.dart';
import 'package:stimmungsringeapp/data/sentiment.dart';

class Suggestion {
  final String text;

  static Suggestion fromJson(Map<String, dynamic> jsonMap) {
    return Suggestion(jsonMap['text'] as String);
  }

  const Suggestion(this.text);
}

class OtherDetail {
  final UserMinimal user;
  final Sentiment sentiment;
  final List<Suggestion> suggestions;

  static OtherDetail fromJson(Map<String, dynamic> jsonMap) {
    final suggestionsJson = jsonMap['suggestions'] as List<dynamic>;
    return OtherDetail(
        UserMinimal.fromJson(jsonMap['user'] as Map<String, dynamic>),
        sentimentFromJson(jsonMap['sentiment'] as String),
        suggestionsJson
            .map((dynamic sugg) =>
                Suggestion.fromJson(sugg as Map<String, dynamic>))
            .toList(growable: false));
  }

  OtherDetail(this.user, this.sentiment, this.suggestions);
}
