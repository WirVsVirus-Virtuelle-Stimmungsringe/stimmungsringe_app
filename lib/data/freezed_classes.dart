import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'freezed_classes.freezed.dart';
part 'freezed_classes.g.dart';

// on compile error "_$SentimentFromJson" -> delete *.g.dart file

@immutable
abstract class UserMinimal with _$UserMinimal {
  const factory UserMinimal(String userId, String displayName) = _UserMinimal;
  factory UserMinimal.fromJson(Map<String, dynamic> json) =>
      _$UserMinimalFromJson(json);
}

@immutable
abstract class Sentiment with _$Sentiment {
  const factory Sentiment(String sentimentCode) = _Sentiment;
  factory Sentiment.fromJson(Map<String, dynamic> json) =>
      _$SentimentFromJson(json);
}

@immutable
abstract class SentimentStatus with _$SentimentStatus {
  const factory SentimentStatus(Sentiment sentiment) = _SentimentStatus;
  factory SentimentStatus.fromJson(Map<String, dynamic> json) =>
      _$SentimentStatusFromJson(json);
}

@immutable
abstract class OtherTile with _$OtherTile {
  const factory OtherTile(UserMinimal user, SentimentStatus sentimentStatus) =
      _OtherTile;
  factory OtherTile.fromJson(Map<String, dynamic> json) =>
      _$OtherTileFromJson(json);
}

@immutable
abstract class MyTile with _$MyTile {
  const factory MyTile(UserMinimal user, SentimentStatus sentimentStatus) =
      _MyTile;
  factory MyTile.fromJson(Map<String, dynamic> json) => _$MyTileFromJson(json);
}

@immutable
abstract class Dashboard with _$Dashboard {
  const factory Dashboard(List<OtherTile> otherTiles, UserMinimal user,
      SentimentStatus sentiment) = _Dashboard;
  factory Dashboard.fromJson(Map<String, dynamic> json) =>
      _$DashboardFromJson(json);
}
