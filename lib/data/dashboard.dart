import 'package:built_collection/built_collection.dart';
import 'package:equatable/equatable.dart';
import 'package:stimmungsringeapp/data/sentiment.dart';

class UserMinimal extends Equatable {
  final String userId;
  final String displayName;
  final bool hasName;

  @override
  List<Object> get props => [userId, displayName, hasName];

  static UserMinimal fromJson(Map<String, dynamic> jsonMap) {
    return UserMinimal(
      jsonMap['userId'] as String,
      jsonMap['displayName'] as String,
      jsonMap['hasName'] as bool,
    );
  }

  const UserMinimal(this.userId, this.displayName, this.hasName);
}

class Suggestion extends Equatable {
  final String text;

  @override
  List<Object> get props => [text];

  static Suggestion fromJson(Map<String, dynamic> jsonMap) {
    return Suggestion(
      jsonMap['text'] as String,
    );
  }

  const Suggestion(this.text);
}

class OtherTile extends Equatable {
  final UserMinimal user;
  final Sentiment sentiment;

  @override
  List<Object> get props => [user, sentiment];

  static OtherTile fromJson(Map<String, dynamic> jsonMap) {
    return OtherTile(
      UserMinimal.fromJson(jsonMap['user'] as Map<String, dynamic>),
      sentimentFromJson(jsonMap['sentiment'] as String),
    );
  }

  const OtherTile(this.user, this.sentiment);
}

class OtherDetail extends Equatable {
  final UserMinimal user;
  final Sentiment sentiment;
  final BuiltList<Suggestion> suggestions;

  @override
  List<Object> get props => [user, sentiment, suggestions];

  static OtherDetail fromJson(Map<String, dynamic> jsonMap) {
    return OtherDetail(
      UserMinimal.fromJson(jsonMap['user'] as Map<String, dynamic>),
      sentimentFromJson(jsonMap['sentiment'] as String),
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

class MyTile extends Equatable {
  final UserMinimal user;
  final Sentiment sentiment;

  @override
  List<Object> get props => [user, sentiment];

  static MyTile fromJson(Map<String, dynamic> jsonMap) {
    return MyTile(
      UserMinimal.fromJson(jsonMap['user'] as Map<String, dynamic>),
      sentimentFromJson(jsonMap['sentiment'] as String),
    );
  }

  const MyTile(this.user, this.sentiment);

  MyTile copyWith({UserMinimal user, Sentiment sentiment}) {
    return MyTile(
      user ?? this.user,
      sentiment ?? this.sentiment,
    );
  }
}

class GroupData extends Equatable {
  final String groupName;
  final String groupCode;

  @override
  List<Object> get props => [groupName, groupCode];

  static GroupData fromJson(Map<String, dynamic> jsonMap) {
    return GroupData(
      jsonMap['groupName'] as String,
      jsonMap['groupCode'] as String,
    );
  }

  const GroupData(this.groupName, this.groupCode);
}

class Dashboard extends Equatable {
  final MyTile myTile;
  final BuiltList<OtherTile> otherTiles;
  final GroupData groupData;

  @override
  List<Object> get props => [myTile, otherTiles, groupData];

  static Dashboard fromJson(Map<String, dynamic> jsonMap) {
    return Dashboard(
      MyTile.fromJson(jsonMap['myTile'] as Map<String, dynamic>),
      BuiltList.of(
        (jsonMap['otherTiles'] as List<dynamic>).map(
          (dynamic otherTile) =>
              OtherTile.fromJson(otherTile as Map<String, dynamic>),
        ),
      ),
      jsonMap['groupData'] != null
          ? GroupData.fromJson(jsonMap['groupData'] as Map<String, dynamic>)
          : null,
    );
  }

  const Dashboard(this.myTile, this.otherTiles, this.groupData);

  Dashboard copyWith(
      {MyTile myTile, BuiltList<OtherTile> otherTiles, GroupData groupData}) {
    return Dashboard(
      myTile ?? this.myTile,
      otherTiles ?? this.otherTiles,
      groupData ?? this.groupData,
    );
  }
}
