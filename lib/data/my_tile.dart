import 'package:equatable/equatable.dart';
import 'package:familiarise/data/sentiment.dart';
import 'package:familiarise/data/user_minimal.dart';

class MyTile extends Equatable {
  final UserMinimal user;
  final Sentiment sentiment;
  final String sentimentText;
  final DateTime lastStatusUpdate;

  @override
  List<Object> get props => [user, sentiment, lastStatusUpdate];

  static MyTile fromJson(Map<String, dynamic> jsonMap) {
    return MyTile(
      UserMinimal.fromJson(jsonMap['user'] as Map<String, dynamic>),
      SentimentExtension.fromJson(jsonMap['sentiment'] as String),
      jsonMap['sentimentText'] as String/*!*/,
      DateTime.parse(jsonMap['lastStatusUpdate'] as String),
    );
  }

  const MyTile(
      this.user, this.sentiment, this.sentimentText, this.lastStatusUpdate);

  MyTile copyWith({
    UserMinimal user,
    Sentiment sentiment,
    String sentimentText,
    DateTime lastStatusUpdate,
  }) {
    return MyTile(
      user ?? this.user,
      sentiment ?? this.sentiment,
      sentimentText ?? this.sentimentText,
      lastStatusUpdate ?? this.lastStatusUpdate,
    );
  }
}
