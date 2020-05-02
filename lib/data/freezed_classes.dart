import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:stimmungsringeapp/data/sentiment.dart';

part 'freezed_classes.freezed.dart';
part 'freezed_classes.g.dart';

// flutter pub run build_runner watch --delete-conflicting-outputs
// on compile error "_$SentimentFromJson" -> delete *.g.dart file
// on compile error touch *.freezed.dart

@immutable
abstract class UserMinimal with _$UserMinimal {
  const factory UserMinimal(String userId, String displayName, bool hasName) =
      _UserMinimal;
  factory UserMinimal.fromJson(Map<String, dynamic> json) =>
      _$UserMinimalFromJson(json);
}


@immutable
abstract class Suggestion with _$Suggestion {
  const factory Suggestion(String text) = _Suggestion;
  factory Suggestion.fromJson(Map<String, dynamic> json) =>
      _$SuggestionFromJson(json);
}

@immutable
abstract class OtherTile with _$OtherTile {
  const factory OtherTile(
      UserMinimal user, Sentiment sentiment, DateTime lastUpdated) = _OtherTile;
  factory OtherTile.fromJson(Map<String, dynamic> json) =>
      _$OtherTileFromJson(json);
}

@immutable
abstract class OtherDetail with _$OtherDetail {
  const factory OtherDetail(
          UserMinimal user, Sentiment sentiment, List<Suggestion> suggestions) =
      _OtherDetail;
  factory OtherDetail.fromJson(Map<String, dynamic> json) =>
      _$OtherDetailFromJson(json);
}

@immutable
abstract class MyTile with _$MyTile {
  const factory MyTile(
      UserMinimal user, Sentiment sentiment, DateTime lastUpdated) = _MyTile;
  factory MyTile.fromJson(Map<String, dynamic> json) => _$MyTileFromJson(json);
}

@immutable
abstract class GroupData with _$GroupData {
  const factory GroupData(String groupName, String groupCode) = _GroupData;
  factory GroupData.fromJson(Map<String, dynamic> json) =>
      _$GroupDataFromJson(json);
}

@immutable
abstract class Dashboard with _$Dashboard {
  const factory Dashboard(
          MyTile myTile, List<OtherTile> otherTiles, GroupData groupData) =
      _Dashboard;
  factory Dashboard.fromJson(Map<String, dynamic> json) =>
      _$DashboardFromJson(json);
}

@immutable
abstract class SentimentUpdate with _$SentimentUpdate {
  const factory SentimentUpdate(String sentiment) = _SentimentUpdate;
  factory SentimentUpdate.fromJson(Map<String, dynamic> json) =>
      _$SentimentUpdateFromJson(json);
}
