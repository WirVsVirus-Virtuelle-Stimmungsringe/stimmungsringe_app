// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'freezed_classes.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UserMinimal _$_$_UserMinimalFromJson(Map<String, dynamic> json) {
  return _$_UserMinimal(
    json['userId'] as String,
    json['displayName'] as String,
  );
}

Map<String, dynamic> _$_$_UserMinimalToJson(_$_UserMinimal instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'displayName': instance.displayName,
    };

_$_OtherTile _$_$_OtherTileFromJson(Map<String, dynamic> json) {
  return _$_OtherTile(
    json['user'] == null
        ? null
        : UserMinimal.fromJson(json['user'] as Map<String, dynamic>),
    json['sentiment'] == null
        ? null
        : SentimentUi.fromJson(json['sentiment'] as String),
  );
}

Map<String, dynamic> _$_$_OtherTileToJson(_$_OtherTile instance) =>
    <String, dynamic>{
      'user': instance.user,
      'sentiment': instance.sentiment,
    };

_$_MyTile _$_$_MyTileFromJson(Map<String, dynamic> json) {
  return _$_MyTile(
    json['user'] == null
        ? null
        : UserMinimal.fromJson(json['user'] as Map<String, dynamic>),
    json['sentiment'] == null
        ? null
        : SentimentUi.fromJson(json['sentiment'] as String),
  );
}

Map<String, dynamic> _$_$_MyTileToJson(_$_MyTile instance) => <String, dynamic>{
      'user': instance.user,
      'sentiment': instance.sentiment,
    };

_$_Dashboard _$_$_DashboardFromJson(Map<String, dynamic> json) {
  return _$_Dashboard(
    json['myTile'] == null
        ? null
        : MyTile.fromJson(json['myTile'] as Map<String, dynamic>),
    (json['otherTiles'] as List)
        ?.map((e) =>
            e == null ? null : OtherTile.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$_$_DashboardToJson(_$_Dashboard instance) =>
    <String, dynamic>{
      'myTile': instance.myTile,
      'otherTiles': instance.otherTiles,
    };

_$_SentimentUpdate _$_$_SentimentUpdateFromJson(Map<String, dynamic> json) {
  return _$_SentimentUpdate(
    json['sentiment'] as String,
  );
}

Map<String, dynamic> _$_$_SentimentUpdateToJson(_$_SentimentUpdate instance) =>
    <String, dynamic>{
      'sentiment': instance.sentiment,
    };
