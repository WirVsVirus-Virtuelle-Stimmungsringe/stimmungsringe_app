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

_$_Suggestion _$_$_SuggestionFromJson(Map<String, dynamic> json) {
  return _$_Suggestion(
    json['text'] as String,
  );
}

Map<String, dynamic> _$_$_SuggestionToJson(_$_Suggestion instance) =>
    <String, dynamic>{
      'text': instance.text,
    };

_$_OtherTile _$_$_OtherTileFromJson(Map<String, dynamic> json) {
  return _$_OtherTile(
    json['user'] == null
        ? null
        : UserMinimal.fromJson(json['user'] as Map<String, dynamic>),
    _$enumDecodeNullable(_$SentimentEnumMap, json['sentiment']),
  );
}

Map<String, dynamic> _$_$_OtherTileToJson(_$_OtherTile instance) =>
    <String, dynamic>{
      'user': instance.user,
      'sentiment': _$SentimentEnumMap[instance.sentiment],
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$SentimentEnumMap = {
  Sentiment.sunny: 'sunny',
  Sentiment.sunnyWithClouds: 'sunnyWithClouds',
  Sentiment.cloudy: 'cloudy',
  Sentiment.windy: 'windy',
  Sentiment.cloudyNight: 'cloudyNight',
  Sentiment.thundery: 'thundery',
};

_$_OtherDetail _$_$_OtherDetailFromJson(Map<String, dynamic> json) {
  return _$_OtherDetail(
    json['user'] == null
        ? null
        : UserMinimal.fromJson(json['user'] as Map<String, dynamic>),
    _$enumDecodeNullable(_$SentimentEnumMap, json['sentiment']),
    (json['suggestions'] as List)
        ?.map((e) =>
            e == null ? null : Suggestion.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$_$_OtherDetailToJson(_$_OtherDetail instance) =>
    <String, dynamic>{
      'user': instance.user,
      'sentiment': _$SentimentEnumMap[instance.sentiment],
      'suggestions': instance.suggestions,
    };

_$_MyTile _$_$_MyTileFromJson(Map<String, dynamic> json) {
  return _$_MyTile(
    json['user'] == null
        ? null
        : UserMinimal.fromJson(json['user'] as Map<String, dynamic>),
    _$enumDecodeNullable(_$SentimentEnumMap, json['sentiment']),
  );
}

Map<String, dynamic> _$_$_MyTileToJson(_$_MyTile instance) => <String, dynamic>{
      'user': instance.user,
      'sentiment': _$SentimentEnumMap[instance.sentiment],
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
