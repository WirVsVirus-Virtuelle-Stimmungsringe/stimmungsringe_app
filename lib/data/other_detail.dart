import 'package:built_collection/built_collection.dart';
import 'package:equatable/equatable.dart';
import 'package:familiarise/data/sentiment.dart';
import 'package:familiarise/data/suggestion.dart';
import 'package:familiarise/data/user_minimal.dart';

class OtherDetail extends Equatable {
  final UserMinimal user;
  final Sentiment sentiment;
  final BuiltList<Suggestion> suggestions;

  @override
  List<Object> get props => [user, sentiment, suggestions];

  static OtherDetail fromJson(Map<String, dynamic> jsonMap) {
    return OtherDetail(
      UserMinimal.fromJson(jsonMap['user'] as Map<String, dynamic>),
      SentimentExtension.fromJson(jsonMap['sentiment'] as String),
      BuiltList.of(
        (jsonMap['suggestions'] as List<dynamic>).map(
          (dynamic suggestion) =>
              Suggestion.fromJson(suggestion as Map<String, dynamic>),
        ),
      ),
    );
  }

  const OtherDetail(this.user, this.sentiment, this.suggestions);
}
