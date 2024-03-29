import 'package:equatable/equatable.dart';
import 'package:familiarise/data/sentiment.dart';
import 'package:familiarise/data/user_minimal.dart';

class OtherTile extends Equatable {
  final UserMinimal user;
  final Sentiment sentiment;
  final String sentimentText;
  final DateTime lastStatusUpdate;

  @override
  List<Object> get props => [user, sentiment, lastStatusUpdate];

  static OtherTile fromJson(Map<String, dynamic> jsonMap) {
    return OtherTile(
      UserMinimal.fromJson(jsonMap['user'] as Map<String, dynamic>),
      SentimentExtension.fromJson(jsonMap['sentiment'] as String),
      jsonMap['sentimentText'] as String,
      DateTime.parse(jsonMap['lastStatusUpdate'] as String),
    );
  }

  const OtherTile(
    this.user,
    this.sentiment,
    this.sentimentText,
    this.lastStatusUpdate,
  );
}
