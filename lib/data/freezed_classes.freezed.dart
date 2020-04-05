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

Sentiment _$SentimentFromJson(Map<String, dynamic> json) {
  return _Sentiment.fromJson(json);
}

abstract class _$Sentiment {
  String get sentimentCode;

  Sentiment copyWith({String sentimentCode});

  Map<String, dynamic> toJson();
}

@JsonSerializable()
class _$_Sentiment implements _Sentiment {
  const _$_Sentiment(this.sentimentCode);

  factory _$_Sentiment.fromJson(Map<String, dynamic> json) =>
      _$_$_SentimentFromJson(json);

  @override
  final String sentimentCode;

  @override
  String toString() {
    return 'Sentiment(sentimentCode: $sentimentCode)';
  }

  @override
  bool operator ==(dynamic other) {
    return other is _Sentiment &&
        (identical(other.sentimentCode, sentimentCode) ||
            other.sentimentCode == sentimentCode);
  }

  @override
  int get hashCode => runtimeType.hashCode ^ sentimentCode.hashCode;

  @override
  _$_Sentiment copyWith({
    Object sentimentCode = immutable,
  }) {
    return _$_Sentiment(
      sentimentCode == immutable ? this.sentimentCode : sentimentCode as String,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return _$_$_SentimentToJson(this);
  }
}

abstract class _Sentiment implements Sentiment {
  const factory _Sentiment(String sentimentCode) = _$_Sentiment;

  factory _Sentiment.fromJson(Map<String, dynamic> json) =
      _$_Sentiment.fromJson;

  @override
  String get sentimentCode;

  @override
  _Sentiment copyWith({String sentimentCode});
}

SentimentStatus _$SentimentStatusFromJson(Map<String, dynamic> json) {
  return _SentimentStatus.fromJson(json);
}

abstract class _$SentimentStatus {
  Sentiment get sentiment;

  SentimentStatus copyWith({Sentiment sentiment});

  Map<String, dynamic> toJson();
}

@JsonSerializable()
class _$_SentimentStatus implements _SentimentStatus {
  const _$_SentimentStatus(this.sentiment);

  factory _$_SentimentStatus.fromJson(Map<String, dynamic> json) =>
      _$_$_SentimentStatusFromJson(json);

  @override
  final Sentiment sentiment;

  @override
  String toString() {
    return 'SentimentStatus(sentiment: $sentiment)';
  }

  @override
  bool operator ==(dynamic other) {
    return other is _SentimentStatus &&
        (identical(other.sentiment, sentiment) || other.sentiment == sentiment);
  }

  @override
  int get hashCode => runtimeType.hashCode ^ sentiment.hashCode;

  @override
  _$_SentimentStatus copyWith({
    Object sentiment = immutable,
  }) {
    return _$_SentimentStatus(
      sentiment == immutable ? this.sentiment : sentiment as Sentiment,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return _$_$_SentimentStatusToJson(this);
  }
}

abstract class _SentimentStatus implements SentimentStatus {
  const factory _SentimentStatus(Sentiment sentiment) = _$_SentimentStatus;

  factory _SentimentStatus.fromJson(Map<String, dynamic> json) =
      _$_SentimentStatus.fromJson;

  @override
  Sentiment get sentiment;

  @override
  _SentimentStatus copyWith({Sentiment sentiment});
}

OtherTile _$OtherTileFromJson(Map<String, dynamic> json) {
  return _OtherTile.fromJson(json);
}

abstract class _$OtherTile {
  UserMinimal get user;
  SentimentStatus get sentimentStatus;

  OtherTile copyWith({UserMinimal user, SentimentStatus sentimentStatus});

  Map<String, dynamic> toJson();
}

@JsonSerializable()
class _$_OtherTile implements _OtherTile {
  const _$_OtherTile(this.user, this.sentimentStatus);

  factory _$_OtherTile.fromJson(Map<String, dynamic> json) =>
      _$_$_OtherTileFromJson(json);

  @override
  final UserMinimal user;
  @override
  final SentimentStatus sentimentStatus;

  @override
  String toString() {
    return 'OtherTile(user: $user, sentimentStatus: $sentimentStatus)';
  }

  @override
  bool operator ==(dynamic other) {
    return other is _OtherTile &&
        (identical(other.user, user) || other.user == user) &&
        (identical(other.sentimentStatus, sentimentStatus) ||
            other.sentimentStatus == sentimentStatus);
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ user.hashCode ^ sentimentStatus.hashCode;

  @override
  _$_OtherTile copyWith({
    Object user = immutable,
    Object sentimentStatus = immutable,
  }) {
    return _$_OtherTile(
      user == immutable ? this.user : user as UserMinimal,
      sentimentStatus == immutable
          ? this.sentimentStatus
          : sentimentStatus as SentimentStatus,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return _$_$_OtherTileToJson(this);
  }
}

abstract class _OtherTile implements OtherTile {
  const factory _OtherTile(UserMinimal user, SentimentStatus sentimentStatus) =
      _$_OtherTile;

  factory _OtherTile.fromJson(Map<String, dynamic> json) =
      _$_OtherTile.fromJson;

  @override
  UserMinimal get user;
  @override
  SentimentStatus get sentimentStatus;

  @override
  _OtherTile copyWith({UserMinimal user, SentimentStatus sentimentStatus});
}

MyTile _$MyTileFromJson(Map<String, dynamic> json) {
  return _MyTile.fromJson(json);
}

abstract class _$MyTile {
  UserMinimal get user;
  SentimentStatus get sentimentStatus;

  MyTile copyWith({UserMinimal user, SentimentStatus sentimentStatus});

  Map<String, dynamic> toJson();
}

@JsonSerializable()
class _$_MyTile implements _MyTile {
  const _$_MyTile(this.user, this.sentimentStatus);

  factory _$_MyTile.fromJson(Map<String, dynamic> json) =>
      _$_$_MyTileFromJson(json);

  @override
  final UserMinimal user;
  @override
  final SentimentStatus sentimentStatus;

  @override
  String toString() {
    return 'MyTile(user: $user, sentimentStatus: $sentimentStatus)';
  }

  @override
  bool operator ==(dynamic other) {
    return other is _MyTile &&
        (identical(other.user, user) || other.user == user) &&
        (identical(other.sentimentStatus, sentimentStatus) ||
            other.sentimentStatus == sentimentStatus);
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ user.hashCode ^ sentimentStatus.hashCode;

  @override
  _$_MyTile copyWith({
    Object user = immutable,
    Object sentimentStatus = immutable,
  }) {
    return _$_MyTile(
      user == immutable ? this.user : user as UserMinimal,
      sentimentStatus == immutable
          ? this.sentimentStatus
          : sentimentStatus as SentimentStatus,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return _$_$_MyTileToJson(this);
  }
}

abstract class _MyTile implements MyTile {
  const factory _MyTile(UserMinimal user, SentimentStatus sentimentStatus) =
      _$_MyTile;

  factory _MyTile.fromJson(Map<String, dynamic> json) = _$_MyTile.fromJson;

  @override
  UserMinimal get user;
  @override
  SentimentStatus get sentimentStatus;

  @override
  _MyTile copyWith({UserMinimal user, SentimentStatus sentimentStatus});
}

Dashboard _$DashboardFromJson(Map<String, dynamic> json) {
  return _Dashboard.fromJson(json);
}

abstract class _$Dashboard {
  List<OtherTile> get otherTiles;
  UserMinimal get user;
  SentimentStatus get sentiment;

  Dashboard copyWith(
      {List<OtherTile> otherTiles,
      UserMinimal user,
      SentimentStatus sentiment});

  Map<String, dynamic> toJson();
}

@JsonSerializable()
class _$_Dashboard implements _Dashboard {
  const _$_Dashboard(this.otherTiles, this.user, this.sentiment);

  factory _$_Dashboard.fromJson(Map<String, dynamic> json) =>
      _$_$_DashboardFromJson(json);

  @override
  final List<OtherTile> otherTiles;
  @override
  final UserMinimal user;
  @override
  final SentimentStatus sentiment;

  @override
  String toString() {
    return 'Dashboard(otherTiles: $otherTiles, user: $user, sentiment: $sentiment)';
  }

  @override
  bool operator ==(dynamic other) {
    return other is _Dashboard &&
        (identical(other.otherTiles, otherTiles) ||
            other.otherTiles == otherTiles) &&
        (identical(other.user, user) || other.user == user) &&
        (identical(other.sentiment, sentiment) || other.sentiment == sentiment);
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      otherTiles.hashCode ^
      user.hashCode ^
      sentiment.hashCode;

  @override
  _$_Dashboard copyWith({
    Object otherTiles = immutable,
    Object user = immutable,
    Object sentiment = immutable,
  }) {
    return _$_Dashboard(
      otherTiles == immutable ? this.otherTiles : otherTiles as List<OtherTile>,
      user == immutable ? this.user : user as UserMinimal,
      sentiment == immutable ? this.sentiment : sentiment as SentimentStatus,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return _$_$_DashboardToJson(this);
  }
}

abstract class _Dashboard implements Dashboard {
  const factory _Dashboard(List<OtherTile> otherTiles, UserMinimal user,
      SentimentStatus sentiment) = _$_Dashboard;

  factory _Dashboard.fromJson(Map<String, dynamic> json) =
      _$_Dashboard.fromJson;

  @override
  List<OtherTile> get otherTiles;
  @override
  UserMinimal get user;
  @override
  SentimentStatus get sentiment;

  @override
  _Dashboard copyWith(
      {List<OtherTile> otherTiles,
      UserMinimal user,
      SentimentStatus sentiment});
}
