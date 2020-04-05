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

_$_Sentiment _$_$_SentimentFromJson(Map<String, dynamic> json) {
  return _$_Sentiment(
    json['sentimentCode'] as String,
  );
}

Map<String, dynamic> _$_$_SentimentToJson(_$_Sentiment instance) =>
    <String, dynamic>{
      'sentimentCode': instance.sentimentCode,
    };

_$_SentimentStatus _$_$_SentimentStatusFromJson(Map<String, dynamic> json) {
  return _$_SentimentStatus(
    json['sentiment'] == null
        ? null
        : Sentiment.fromJson(json['sentiment'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$_$_SentimentStatusToJson(_$_SentimentStatus instance) =>
    <String, dynamic>{
      'sentiment': instance.sentiment,
    };

_$_OtherTile _$_$_OtherTileFromJson(Map<String, dynamic> json) {
  return _$_OtherTile(
    json['user'] == null
        ? null
        : UserMinimal.fromJson(json['user'] as Map<String, dynamic>),
    json['sentimentStatus'] == null
        ? null
        : SentimentStatus.fromJson(
            json['sentimentStatus'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$_$_OtherTileToJson(_$_OtherTile instance) =>
    <String, dynamic>{
      'user': instance.user,
      'sentimentStatus': instance.sentimentStatus,
    };

_$_MyTile _$_$_MyTileFromJson(Map<String, dynamic> json) {
  return _$_MyTile(
    json['user'] == null
        ? null
        : UserMinimal.fromJson(json['user'] as Map<String, dynamic>),
    json['sentimentStatus'] == null
        ? null
        : SentimentStatus.fromJson(
            json['sentimentStatus'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$_$_MyTileToJson(_$_MyTile instance) => <String, dynamic>{
      'user': instance.user,
      'sentimentStatus': instance.sentimentStatus,
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
