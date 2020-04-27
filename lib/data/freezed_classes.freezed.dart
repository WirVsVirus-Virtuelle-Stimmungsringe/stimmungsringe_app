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

  UserMinimal copyWith({String userId, String displayName});

  Map<String, dynamic> toJson();
}

@JsonSerializable()
class _$_UserMinimal implements _UserMinimal {
  const _$_UserMinimal(this.userId, this.displayName);

  factory _$_UserMinimal.fromJson(Map<String, dynamic> json) =>
      _$_$_UserMinimalFromJson(json);

  @override
  final String userId;
  @override
  final String displayName;

  @override
  String toString() {
    return 'UserMinimal(userId: $userId, displayName: $displayName)';
  }

  @override
  bool operator ==(dynamic other) {
    return other is _UserMinimal &&
        (identical(other.userId, userId) || other.userId == userId) &&
        (identical(other.displayName, displayName) ||
            other.displayName == displayName);
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ userId.hashCode ^ displayName.hashCode;

  @override
  _$_UserMinimal copyWith({
    Object userId = immutable,
    Object displayName = immutable,
  }) {
    return _$_UserMinimal(
      userId == immutable ? this.userId : userId as String,
      displayName == immutable ? this.displayName : displayName as String,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return _$_$_UserMinimalToJson(this);
  }
}

abstract class _UserMinimal implements UserMinimal {
  const factory _UserMinimal(String userId, String displayName) =
      _$_UserMinimal;

  factory _UserMinimal.fromJson(Map<String, dynamic> json) =
      _$_UserMinimal.fromJson;

  @override
  String get userId;
  @override
  String get displayName;

  @override
  _UserMinimal copyWith({String userId, String displayName});
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
  DateTime get lastUpdated;

  OtherTile copyWith(
      {UserMinimal user, Sentiment sentiment, DateTime lastUpdated});

  Map<String, dynamic> toJson();
}

@JsonSerializable()
class _$_OtherTile implements _OtherTile {
  const _$_OtherTile(this.user, this.sentiment, this.lastUpdated);

  factory _$_OtherTile.fromJson(Map<String, dynamic> json) =>
      _$_$_OtherTileFromJson(json);

  @override
  final UserMinimal user;
  @override
  final Sentiment sentiment;
  @override
  final DateTime lastUpdated;

  @override
  String toString() {
    return 'OtherTile(user: $user, sentiment: $sentiment, lastUpdated: $lastUpdated)';
  }

  @override
  bool operator ==(dynamic other) {
    return other is _OtherTile &&
        (identical(other.user, user) || other.user == user) &&
        (identical(other.sentiment, sentiment) ||
            other.sentiment == sentiment) &&
        (identical(other.lastUpdated, lastUpdated) ||
            other.lastUpdated == lastUpdated);
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      user.hashCode ^
      sentiment.hashCode ^
      lastUpdated.hashCode;

  @override
  _$_OtherTile copyWith({
    Object user = immutable,
    Object sentiment = immutable,
    Object lastUpdated = immutable,
  }) {
    return _$_OtherTile(
      user == immutable ? this.user : user as UserMinimal,
      sentiment == immutable ? this.sentiment : sentiment as Sentiment,
      lastUpdated == immutable ? this.lastUpdated : lastUpdated as DateTime,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return _$_$_OtherTileToJson(this);
  }
}

abstract class _OtherTile implements OtherTile {
  const factory _OtherTile(
          UserMinimal user, Sentiment sentiment, DateTime lastUpdated) =
      _$_OtherTile;

  factory _OtherTile.fromJson(Map<String, dynamic> json) =
      _$_OtherTile.fromJson;

  @override
  UserMinimal get user;
  @override
  Sentiment get sentiment;
  @override
  DateTime get lastUpdated;

  @override
  _OtherTile copyWith(
      {UserMinimal user, Sentiment sentiment, DateTime lastUpdated});
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
  DateTime get lastUpdated;

  MyTile copyWith(
      {UserMinimal user, Sentiment sentiment, DateTime lastUpdated});

  Map<String, dynamic> toJson();
}

@JsonSerializable()
class _$_MyTile implements _MyTile {
  const _$_MyTile(this.user, this.sentiment, this.lastUpdated);

  factory _$_MyTile.fromJson(Map<String, dynamic> json) =>
      _$_$_MyTileFromJson(json);

  @override
  final UserMinimal user;
  @override
  final Sentiment sentiment;
  @override
  final DateTime lastUpdated;

  @override
  String toString() {
    return 'MyTile(user: $user, sentiment: $sentiment, lastUpdated: $lastUpdated)';
  }

  @override
  bool operator ==(dynamic other) {
    return other is _MyTile &&
        (identical(other.user, user) || other.user == user) &&
        (identical(other.sentiment, sentiment) ||
            other.sentiment == sentiment) &&
        (identical(other.lastUpdated, lastUpdated) ||
            other.lastUpdated == lastUpdated);
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      user.hashCode ^
      sentiment.hashCode ^
      lastUpdated.hashCode;

  @override
  _$_MyTile copyWith({
    Object user = immutable,
    Object sentiment = immutable,
    Object lastUpdated = immutable,
  }) {
    return _$_MyTile(
      user == immutable ? this.user : user as UserMinimal,
      sentiment == immutable ? this.sentiment : sentiment as Sentiment,
      lastUpdated == immutable ? this.lastUpdated : lastUpdated as DateTime,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return _$_$_MyTileToJson(this);
  }
}

abstract class _MyTile implements MyTile {
  const factory _MyTile(
      UserMinimal user, Sentiment sentiment, DateTime lastUpdated) = _$_MyTile;

  factory _MyTile.fromJson(Map<String, dynamic> json) = _$_MyTile.fromJson;

  @override
  UserMinimal get user;
  @override
  Sentiment get sentiment;
  @override
  DateTime get lastUpdated;

  @override
  _MyTile copyWith(
      {UserMinimal user, Sentiment sentiment, DateTime lastUpdated});
}

Dashboard _$DashboardFromJson(Map<String, dynamic> json) {
  return _Dashboard.fromJson(json);
}

abstract class _$Dashboard {
  MyTile get myTile;
  List<OtherTile> get otherTiles;

  Dashboard copyWith({MyTile myTile, List<OtherTile> otherTiles});

  Map<String, dynamic> toJson();
}

@JsonSerializable()
class _$_Dashboard implements _Dashboard {
  const _$_Dashboard(this.myTile, this.otherTiles);

  factory _$_Dashboard.fromJson(Map<String, dynamic> json) =>
      _$_$_DashboardFromJson(json);

  @override
  final MyTile myTile;
  @override
  final List<OtherTile> otherTiles;

  @override
  String toString() {
    return 'Dashboard(myTile: $myTile, otherTiles: $otherTiles)';
  }

  @override
  bool operator ==(dynamic other) {
    return other is _Dashboard &&
        (identical(other.myTile, myTile) || other.myTile == myTile) &&
        (identical(other.otherTiles, otherTiles) ||
            other.otherTiles == otherTiles);
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ myTile.hashCode ^ otherTiles.hashCode;

  @override
  _$_Dashboard copyWith({
    Object myTile = immutable,
    Object otherTiles = immutable,
  }) {
    return _$_Dashboard(
      myTile == immutable ? this.myTile : myTile as MyTile,
      otherTiles == immutable ? this.otherTiles : otherTiles as List<OtherTile>,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return _$_$_DashboardToJson(this);
  }
}

abstract class _Dashboard implements Dashboard {
  const factory _Dashboard(MyTile myTile, List<OtherTile> otherTiles) =
      _$_Dashboard;

  factory _Dashboard.fromJson(Map<String, dynamic> json) =
      _$_Dashboard.fromJson;

  @override
  MyTile get myTile;
  @override
  List<OtherTile> get otherTiles;

  @override
  _Dashboard copyWith({MyTile myTile, List<OtherTile> otherTiles});
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
