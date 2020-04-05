import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:stimmungsringeapp/data/sentiment.dart';

part 'freezed_classes.freezed.dart';
part 'freezed_classes.g.dart';

// flutter pub run build_runner watch --delete-conflicting-outputs
// on compile error "_$SentimentFromJson" -> delete *.g.dart file

@immutable
abstract class UserMinimal with _$UserMinimal {
  const factory UserMinimal(String userId, String displayName) = _UserMinimal;
  factory UserMinimal.fromJson(Map<String, dynamic> json) =>
      _$UserMinimalFromJson(json);
}

@immutable
abstract class OtherTile with _$OtherTile {
  const factory OtherTile(UserMinimal user, SentimentUi sentiment) = _OtherTile;
  factory OtherTile.fromJson(Map<String, dynamic> json) =>
      _$OtherTileFromJson(json);
}

@immutable
abstract class MyTile with _$MyTile {
  const factory MyTile(UserMinimal user, SentimentUi sentiment) = _MyTile;
  factory MyTile.fromJson(Map<String, dynamic> json) => _$MyTileFromJson(json);
}

@immutable
abstract class Dashboard with _$Dashboard {
  const factory Dashboard(MyTile myTile, List<OtherTile> otherTiles) =
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
