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
class _$_UserMinimal with DiagnosticableTreeMixin implements _UserMinimal {
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
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.debug}) {
    return 'UserMinimal(userId: $userId, displayName: $displayName, hasName: $hasName)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'UserMinimal'))
      ..add(DiagnosticsProperty('userId', userId))
      ..add(DiagnosticsProperty('displayName', displayName))
      ..add(DiagnosticsProperty('hasName', hasName));
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

abstract class _$Suggestion {
  String get text;

  Suggestion copyWith({String text});
}

class _$_Suggestion with DiagnosticableTreeMixin implements _Suggestion {
  const _$_Suggestion(this.text);

  @override
  final String text;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.debug}) {
    return 'Suggestion(text: $text)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Suggestion'))
      ..add(DiagnosticsProperty('text', text));
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
}

abstract class _Suggestion implements Suggestion {
  const factory _Suggestion(String text) = _$_Suggestion;

  @override
  String get text;

  @override
  _Suggestion copyWith({String text});
}

abstract class _$OtherTile {
  UserMinimal get user;
  Sentiment get sentiment;
  DateTime get lastStatusUpdate;

  OtherTile copyWith(
      {UserMinimal user, Sentiment sentiment, DateTime lastStatusUpdate});
}

class _$_OtherTile with DiagnosticableTreeMixin implements _OtherTile {
  const _$_OtherTile(this.user, this.sentiment, this.lastStatusUpdate);

  @override
  final UserMinimal user;
  @override
  final Sentiment sentiment;
  @override
  final DateTime lastStatusUpdate;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.debug}) {
    return 'OtherTile(user: $user, sentiment: $sentiment, lastStatusUpdate: $lastStatusUpdate)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'OtherTile'))
      ..add(DiagnosticsProperty('user', user))
      ..add(DiagnosticsProperty('sentiment', sentiment))
      ..add(DiagnosticsProperty('lastStatusUpdate', lastStatusUpdate));
  }

  @override
  bool operator ==(dynamic other) {
    return other is _OtherTile &&
        (identical(other.user, user) || other.user == user) &&
        (identical(other.sentiment, sentiment) ||
            other.sentiment == sentiment) &&
        (identical(other.lastStatusUpdate, lastStatusUpdate) ||
            other.lastStatusUpdate == lastStatusUpdate);
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      user.hashCode ^
      sentiment.hashCode ^
      lastStatusUpdate.hashCode;

  @override
  _$_OtherTile copyWith({
    Object user = immutable,
    Object sentiment = immutable,
    Object lastStatusUpdate = immutable,
  }) {
    return _$_OtherTile(
      user == immutable ? this.user : user as UserMinimal,
      sentiment == immutable ? this.sentiment : sentiment as Sentiment,
      lastStatusUpdate == immutable
          ? this.lastStatusUpdate
          : lastStatusUpdate as DateTime,
    );
  }
}

abstract class _OtherTile implements OtherTile {
  const factory _OtherTile(
          UserMinimal user, Sentiment sentiment, DateTime lastStatusUpdate) =
      _$_OtherTile;

  @override
  UserMinimal get user;
  @override
  Sentiment get sentiment;
  @override
  DateTime get lastStatusUpdate;

  @override
  _OtherTile copyWith(
      {UserMinimal user, Sentiment sentiment, DateTime lastStatusUpdate});
}

abstract class _$OtherDetail {
  UserMinimal get user;
  Sentiment get sentiment;
  List<Suggestion> get suggestions;

  OtherDetail copyWith(
      {UserMinimal user, Sentiment sentiment, List<Suggestion> suggestions});
}

class _$_OtherDetail with DiagnosticableTreeMixin implements _OtherDetail {
  const _$_OtherDetail(this.user, this.sentiment, this.suggestions);

  @override
  final UserMinimal user;
  @override
  final Sentiment sentiment;
  @override
  final List<Suggestion> suggestions;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.debug}) {
    return 'OtherDetail(user: $user, sentiment: $sentiment, suggestions: $suggestions)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'OtherDetail'))
      ..add(DiagnosticsProperty('user', user))
      ..add(DiagnosticsProperty('sentiment', sentiment))
      ..add(DiagnosticsProperty('suggestions', suggestions));
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
}

abstract class _OtherDetail implements OtherDetail {
  const factory _OtherDetail(
          UserMinimal user, Sentiment sentiment, List<Suggestion> suggestions) =
      _$_OtherDetail;

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

abstract class _$MyTile {
  UserMinimal get user;
  Sentiment get sentiment;
  DateTime get lastStatusUpdate;

  MyTile copyWith(
      {UserMinimal user, Sentiment sentiment, DateTime lastStatusUpdate});
}

class _$_MyTile with DiagnosticableTreeMixin implements _MyTile {
  const _$_MyTile(this.user, this.sentiment, this.lastStatusUpdate);

  @override
  final UserMinimal user;
  @override
  final Sentiment sentiment;
  @override
  final DateTime lastStatusUpdate;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.debug}) {
    return 'MyTile(user: $user, sentiment: $sentiment, lastStatusUpdate: $lastStatusUpdate)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'MyTile'))
      ..add(DiagnosticsProperty('user', user))
      ..add(DiagnosticsProperty('sentiment', sentiment))
      ..add(DiagnosticsProperty('lastStatusUpdate', lastStatusUpdate));
  }

  @override
  bool operator ==(dynamic other) {
    return other is _MyTile &&
        (identical(other.user, user) || other.user == user) &&
        (identical(other.sentiment, sentiment) ||
            other.sentiment == sentiment) &&
        (identical(other.lastStatusUpdate, lastStatusUpdate) ||
            other.lastStatusUpdate == lastStatusUpdate);
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      user.hashCode ^
      sentiment.hashCode ^
      lastStatusUpdate.hashCode;

  @override
  _$_MyTile copyWith({
    Object user = immutable,
    Object sentiment = immutable,
    Object lastStatusUpdate = immutable,
  }) {
    return _$_MyTile(
      user == immutable ? this.user : user as UserMinimal,
      sentiment == immutable ? this.sentiment : sentiment as Sentiment,
      lastStatusUpdate == immutable
          ? this.lastStatusUpdate
          : lastStatusUpdate as DateTime,
    );
  }
}

abstract class _MyTile implements MyTile {
  const factory _MyTile(
          UserMinimal user, Sentiment sentiment, DateTime lastStatusUpdate) =
      _$_MyTile;

  @override
  UserMinimal get user;
  @override
  Sentiment get sentiment;
  @override
  DateTime get lastStatusUpdate;

  @override
  _MyTile copyWith(
      {UserMinimal user, Sentiment sentiment, DateTime lastStatusUpdate});
}

abstract class _$GroupData {
  String get groupName;
  String get groupCode;

  GroupData copyWith({String groupName, String groupCode});
}

class _$_GroupData with DiagnosticableTreeMixin implements _GroupData {
  const _$_GroupData(this.groupName, this.groupCode);

  @override
  final String groupName;
  @override
  final String groupCode;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.debug}) {
    return 'GroupData(groupName: $groupName, groupCode: $groupCode)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'GroupData'))
      ..add(DiagnosticsProperty('groupName', groupName))
      ..add(DiagnosticsProperty('groupCode', groupCode));
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
}

abstract class _GroupData implements GroupData {
  const factory _GroupData(String groupName, String groupCode) = _$_GroupData;

  @override
  String get groupName;
  @override
  String get groupCode;

  @override
  _GroupData copyWith({String groupName, String groupCode});
}

abstract class _$Dashboard {
  MyTile get myTile;
  List<OtherTile> get otherTiles;
  GroupData get groupData;

  Dashboard copyWith(
      {MyTile myTile, List<OtherTile> otherTiles, GroupData groupData});
}

class _$_Dashboard with DiagnosticableTreeMixin implements _Dashboard {
  const _$_Dashboard(this.myTile, this.otherTiles, this.groupData);

  @override
  final MyTile myTile;
  @override
  final List<OtherTile> otherTiles;
  @override
  final GroupData groupData;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.debug}) {
    return 'Dashboard(myTile: $myTile, otherTiles: $otherTiles, groupData: $groupData)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Dashboard'))
      ..add(DiagnosticsProperty('myTile', myTile))
      ..add(DiagnosticsProperty('otherTiles', otherTiles))
      ..add(DiagnosticsProperty('groupData', groupData));
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
}

abstract class _Dashboard implements Dashboard {
  const factory _Dashboard(
          MyTile myTile, List<OtherTile> otherTiles, GroupData groupData) =
      _$_Dashboard;

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

abstract class _$SentimentUpdate {
  String get sentiment;

  SentimentUpdate copyWith({String sentiment});
}

class _$_SentimentUpdate
    with DiagnosticableTreeMixin
    implements _SentimentUpdate {
  const _$_SentimentUpdate(this.sentiment);

  @override
  final String sentiment;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.debug}) {
    return 'SentimentUpdate(sentiment: $sentiment)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'SentimentUpdate'))
      ..add(DiagnosticsProperty('sentiment', sentiment));
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
}

abstract class _SentimentUpdate implements SentimentUpdate {
  const factory _SentimentUpdate(String sentiment) = _$_SentimentUpdate;

  @override
  String get sentiment;

  @override
  _SentimentUpdate copyWith({String sentiment});
}
