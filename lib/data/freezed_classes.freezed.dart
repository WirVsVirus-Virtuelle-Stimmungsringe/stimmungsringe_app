// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'freezed_classes.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

UserMinimal _$UserMinimalFromJson(Map<String, dynamic> json) {
  return _UserMinimal.fromJson(json);
}

abstract class _$UserMinimal {
  String get userId;
  String get displayName;
  bool get hasName;

  UserMinimal copyWith({String userId, String displayName, bool hasName});

  Map<String, dynamic> toJson();
}

@JsonSerializable()
class _$_UserMinimal implements _UserMinimal {
  const _$_UserMinimal(this.userId, this.displayName, this.hasName);

  factory _$_UserMinimal.fromJson(Map<String, dynamic> json) =>
      _$_$_UserMinimalFromJson(json);

  @override
  final String userId;
  @override
  final String displayName;
  @override
  final bool hasName;

  @override
  String toString() {
    return 'UserMinimal(userId: $userId, displayName: $displayName, hasName: $hasName)';
  }

  @override
  bool operator ==(dynamic other) {
    return other is _UserMinimal &&
        (identical(other.userId, userId) || other.userId == userId) &&
        (identical(other.displayName, displayName) ||
            other.displayName == displayName) &&
        (identical(other.hasName, hasName) || other.hasName == hasName);
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      userId.hashCode ^
      displayName.hashCode ^
      hasName.hashCode;

  @override
  _$_UserMinimal copyWith({
    Object userId = immutable,
    Object displayName = immutable,
    Object hasName = immutable,
  }) {
    return _$_UserMinimal(
      userId == immutable ? this.userId : userId as String,
      displayName == immutable ? this.displayName : displayName as String,
      hasName == immutable ? this.hasName : hasName as bool,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return _$_$_UserMinimalToJson(this);
  }
}

abstract class _UserMinimal implements UserMinimal {
  const factory _UserMinimal(String userId, String displayName, bool hasName) =
      _$_UserMinimal;

  factory _UserMinimal.fromJson(Map<String, dynamic> json) =
      _$_UserMinimal.fromJson;

  @override
  String get userId;
  @override
  String get displayName;
  @override
  bool get hasName;

  @override
  _UserMinimal copyWith({String userId, String displayName, bool hasName});
}

Suggestion _$SuggestionFromJson(Map<String, dynamic> json) {
  return _Suggestion.fromJson(json);
}

abstract class _$Suggestion {
  String get text;

  Suggestion copyWith({String text});

  Map<String, dynamic> toJson();
}

@JsonSerializable()
class _$_Suggestion implements _Suggestion {
  const _$_Suggestion(this.text);

  factory _$_Suggestion.fromJson(Map<String, dynamic> json) =>
      _$_$_SuggestionFromJson(json);

  @override
  final String text;

  @override
  String toString() {
    return 'Suggestion(text: $text)';
  }

  @override
  bool operator ==(dynamic other) {
    return other is _Suggestion &&
        (identical(other.text, text) || other.text == text);
  }

  @override
  int get hashCode => runtimeType.hashCode ^ text.hashCode;

  @override
  _$_Suggestion copyWith({
    Object text = immutable,
  }) {
    return _$_Suggestion(
      text == immutable ? this.text : text as String,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return _$_$_SuggestionToJson(this);
  }
}

abstract class _Suggestion implements Suggestion {
  const factory _Suggestion(String text) = _$_Suggestion;

  factory _Suggestion.fromJson(Map<String, dynamic> json) =
      _$_Suggestion.fromJson;

  @override
  String get text;

  @override
  _Suggestion copyWith({String text});
}

OtherTile _$OtherTileFromJson(Map<String, dynamic> json) {
  return _OtherTile.fromJson(json);
}

abstract class _$OtherTile {
  UserMinimal get user;
  Sentiment get sentiment;

  OtherTile copyWith({UserMinimal user, Sentiment sentiment});

  Map<String, dynamic> toJson();
}

@JsonSerializable()
class _$_OtherTile implements _OtherTile {
  const _$_OtherTile(this.user, this.sentiment);

  factory _$_OtherTile.fromJson(Map<String, dynamic> json) =>
      _$_$_OtherTileFromJson(json);

  @override
  final UserMinimal user;
  @override
  final Sentiment sentiment;

  @override
  String toString() {
    return 'OtherTile(user: $user, sentiment: $sentiment)';
  }

  @override
  bool operator ==(dynamic other) {
    return other is _OtherTile &&
        (identical(other.user, user) || other.user == user) &&
        (identical(other.sentiment, sentiment) || other.sentiment == sentiment);
  }

  @override
  int get hashCode => runtimeType.hashCode ^ user.hashCode ^ sentiment.hashCode;

  @override
  _$_OtherTile copyWith({
    Object user = immutable,
    Object sentiment = immutable,
  }) {
    return _$_OtherTile(
      user == immutable ? this.user : user as UserMinimal,
      sentiment == immutable ? this.sentiment : sentiment as Sentiment,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return _$_$_OtherTileToJson(this);
  }
}

abstract class _OtherTile implements OtherTile {
  const factory _OtherTile(UserMinimal user, Sentiment sentiment) =
      _$_OtherTile;

  factory _OtherTile.fromJson(Map<String, dynamic> json) =
      _$_OtherTile.fromJson;

  @override
  UserMinimal get user;
  @override
  Sentiment get sentiment;

  @override
  _OtherTile copyWith({UserMinimal user, Sentiment sentiment});
}

OtherDetail _$OtherDetailFromJson(Map<String, dynamic> json) {
  return _OtherDetail.fromJson(json);
}

abstract class _$OtherDetail {
  UserMinimal get user;
  Sentiment get sentiment;
  List<Suggestion> get suggestions;

  OtherDetail copyWith(
      {UserMinimal user, Sentiment sentiment, List<Suggestion> suggestions});

  Map<String, dynamic> toJson();
}

@JsonSerializable()
class _$_OtherDetail implements _OtherDetail {
  const _$_OtherDetail(this.user, this.sentiment, this.suggestions);

  factory _$_OtherDetail.fromJson(Map<String, dynamic> json) =>
      _$_$_OtherDetailFromJson(json);

  @override
  final UserMinimal user;
  @override
  final Sentiment sentiment;
  @override
  final List<Suggestion> suggestions;

  @override
  String toString() {
    return 'OtherDetail(user: $user, sentiment: $sentiment, suggestions: $suggestions)';
  }

  @override
  bool operator ==(dynamic other) {
    return other is _OtherDetail &&
        (identical(other.user, user) || other.user == user) &&
        (identical(other.sentiment, sentiment) ||
            other.sentiment == sentiment) &&
        (identical(other.suggestions, suggestions) ||
            other.suggestions == suggestions);
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      user.hashCode ^
      sentiment.hashCode ^
      suggestions.hashCode;

  @override
  _$_OtherDetail copyWith({
    Object user = immutable,
    Object sentiment = immutable,
    Object suggestions = immutable,
  }) {
    return _$_OtherDetail(
      user == immutable ? this.user : user as UserMinimal,
      sentiment == immutable ? this.sentiment : sentiment as Sentiment,
      suggestions == immutable
          ? this.suggestions
          : suggestions as List<Suggestion>,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return _$_$_OtherDetailToJson(this);
  }
}

abstract class _OtherDetail implements OtherDetail {
  const factory _OtherDetail(
          UserMinimal user, Sentiment sentiment, List<Suggestion> suggestions) =
      _$_OtherDetail;

  factory _OtherDetail.fromJson(Map<String, dynamic> json) =
      _$_OtherDetail.fromJson;

  @override
  UserMinimal get user;
  @override
  Sentiment get sentiment;
  @override
  List<Suggestion> get suggestions;

  @override
  _OtherDetail copyWith(
      {UserMinimal user, Sentiment sentiment, List<Suggestion> suggestions});
}

MyTile _$MyTileFromJson(Map<String, dynamic> json) {
  return _MyTile.fromJson(json);
}

abstract class _$MyTile {
  UserMinimal get user;
  Sentiment get sentiment;

  MyTile copyWith({UserMinimal user, Sentiment sentiment});

  Map<String, dynamic> toJson();
}

@JsonSerializable()
class _$_MyTile implements _MyTile {
  const _$_MyTile(this.user, this.sentiment);

  factory _$_MyTile.fromJson(Map<String, dynamic> json) =>
      _$_$_MyTileFromJson(json);

  @override
  final UserMinimal user;
  @override
  final Sentiment sentiment;

  @override
  String toString() {
    return 'MyTile(user: $user, sentiment: $sentiment)';
  }

  @override
  bool operator ==(dynamic other) {
    return other is _MyTile &&
        (identical(other.user, user) || other.user == user) &&
        (identical(other.sentiment, sentiment) || other.sentiment == sentiment);
  }

  @override
  int get hashCode => runtimeType.hashCode ^ user.hashCode ^ sentiment.hashCode;

  @override
  _$_MyTile copyWith({
    Object user = immutable,
    Object sentiment = immutable,
  }) {
    return _$_MyTile(
      user == immutable ? this.user : user as UserMinimal,
      sentiment == immutable ? this.sentiment : sentiment as Sentiment,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return _$_$_MyTileToJson(this);
  }
}

abstract class _MyTile implements MyTile {
  const factory _MyTile(UserMinimal user, Sentiment sentiment) = _$_MyTile;

  factory _MyTile.fromJson(Map<String, dynamic> json) = _$_MyTile.fromJson;

  @override
  UserMinimal get user;
  @override
  Sentiment get sentiment;

  @override
  _MyTile copyWith({UserMinimal user, Sentiment sentiment});
}

GroupData _$GroupDataFromJson(Map<String, dynamic> json) {
  return _GroupData.fromJson(json);
}

abstract class _$GroupData {
  String get groupName;
  String get groupCode;

  GroupData copyWith({String groupName, String groupCode});

  Map<String, dynamic> toJson();
}

@JsonSerializable()
class _$_GroupData implements _GroupData {
  const _$_GroupData(this.groupName, this.groupCode);

  factory _$_GroupData.fromJson(Map<String, dynamic> json) =>
      _$_$_GroupDataFromJson(json);

  @override
  final String groupName;
  @override
  final String groupCode;

  @override
  String toString() {
    return 'GroupData(groupName: $groupName, groupCode: $groupCode)';
  }

  @override
  bool operator ==(dynamic other) {
    return other is _GroupData &&
        (identical(other.groupName, groupName) ||
            other.groupName == groupName) &&
        (identical(other.groupCode, groupCode) || other.groupCode == groupCode);
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ groupName.hashCode ^ groupCode.hashCode;

  @override
  _$_GroupData copyWith({
    Object groupName = immutable,
    Object groupCode = immutable,
  }) {
    return _$_GroupData(
      groupName == immutable ? this.groupName : groupName as String,
      groupCode == immutable ? this.groupCode : groupCode as String,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return _$_$_GroupDataToJson(this);
  }
}

abstract class _GroupData implements GroupData {
  const factory _GroupData(String groupName, String groupCode) = _$_GroupData;

  factory _GroupData.fromJson(Map<String, dynamic> json) =
      _$_GroupData.fromJson;

  @override
  String get groupName;
  @override
  String get groupCode;

  @override
  _GroupData copyWith({String groupName, String groupCode});
}

Dashboard _$DashboardFromJson(Map<String, dynamic> json) {
  return _Dashboard.fromJson(json);
}

abstract class _$Dashboard {
  MyTile get myTile;
  List<OtherTile> get otherTiles;
  GroupData get groupData;

  Dashboard copyWith(
      {MyTile myTile, List<OtherTile> otherTiles, GroupData groupData});

  Map<String, dynamic> toJson();
}

@JsonSerializable()
class _$_Dashboard implements _Dashboard {
  const _$_Dashboard(this.myTile, this.otherTiles, this.groupData);

  factory _$_Dashboard.fromJson(Map<String, dynamic> json) =>
      _$_$_DashboardFromJson(json);

  @override
  final MyTile myTile;
  @override
  final List<OtherTile> otherTiles;
  @override
  final GroupData groupData;

  @override
  String toString() {
    return 'Dashboard(myTile: $myTile, otherTiles: $otherTiles, groupData: $groupData)';
  }

  @override
  bool operator ==(dynamic other) {
    return other is _Dashboard &&
        (identical(other.myTile, myTile) || other.myTile == myTile) &&
        (identical(other.otherTiles, otherTiles) ||
            other.otherTiles == otherTiles) &&
        (identical(other.groupData, groupData) || other.groupData == groupData);
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      myTile.hashCode ^
      otherTiles.hashCode ^
      groupData.hashCode;

  @override
  _$_Dashboard copyWith({
    Object myTile = immutable,
    Object otherTiles = immutable,
    Object groupData = immutable,
  }) {
    return _$_Dashboard(
      myTile == immutable ? this.myTile : myTile as MyTile,
      otherTiles == immutable ? this.otherTiles : otherTiles as List<OtherTile>,
      groupData == immutable ? this.groupData : groupData as GroupData,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return _$_$_DashboardToJson(this);
  }
}

abstract class _Dashboard implements Dashboard {
  const factory _Dashboard(
          MyTile myTile, List<OtherTile> otherTiles, GroupData groupData) =
      _$_Dashboard;

  factory _Dashboard.fromJson(Map<String, dynamic> json) =
      _$_Dashboard.fromJson;

  @override
  MyTile get myTile;
  @override
  List<OtherTile> get otherTiles;
  @override
  GroupData get groupData;

  @override
  _Dashboard copyWith(
      {MyTile myTile, List<OtherTile> otherTiles, GroupData groupData});
}

SentimentUpdate _$SentimentUpdateFromJson(Map<String, dynamic> json) {
  return _SentimentUpdate.fromJson(json);
}

abstract class _$SentimentUpdate {
  String get sentiment;

  SentimentUpdate copyWith({String sentiment});

  Map<String, dynamic> toJson();
}

@JsonSerializable()
class _$_SentimentUpdate implements _SentimentUpdate {
  const _$_SentimentUpdate(this.sentiment);

  factory _$_SentimentUpdate.fromJson(Map<String, dynamic> json) =>
      _$_$_SentimentUpdateFromJson(json);

  @override
  final String sentiment;

  @override
  String toString() {
    return 'SentimentUpdate(sentiment: $sentiment)';
  }

  @override
  bool operator ==(dynamic other) {
    return other is _SentimentUpdate &&
        (identical(other.sentiment, sentiment) || other.sentiment == sentiment);
  }

  @override
  int get hashCode => runtimeType.hashCode ^ sentiment.hashCode;

  @override
  _$_SentimentUpdate copyWith({
    Object sentiment = immutable,
  }) {
    return _$_SentimentUpdate(
      sentiment == immutable ? this.sentiment : sentiment as String,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return _$_$_SentimentUpdateToJson(this);
  }
}

abstract class _SentimentUpdate implements SentimentUpdate {
  const factory _SentimentUpdate(String sentiment) = _$_SentimentUpdate;

  factory _SentimentUpdate.fromJson(Map<String, dynamic> json) =
      _$_SentimentUpdate.fromJson;

  @override
  String get sentiment;

  @override
  _SentimentUpdate copyWith({String sentiment});
}
