import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:stimmungsringeapp/data/freezed_classes.dart';
import 'package:stimmungsringeapp/data/sentiment.dart';
import 'package:stimmungsringeapp/global_constants.dart';

Future<OtherDetail> loadOtherDetailPageData(String userId) async {
  final String url = restUrlOtherStatus(userId);

  http.Response response = await http.get(
    url,
    headers: {'X-User-ID': sampleUserMutti},
  );

  //await new Future.delayed(const Duration(seconds: 1));

  final OtherDetail detailPage =
      OtherDetail.fromJson(json.decode(response.body) as Map<String, dynamic>);

  await chaosMonkeyDelayAsync();
  return detailPage;
}

class Suggestion {
  final String text;

  static Suggestion fromJson(Map<String, dynamic> jsonMap) {
    return Suggestion(jsonMap['text'] as String);
  }

  const Suggestion(this.text);
}

class OtherDetail {
  final UserMinimal user;
  final Sentiment sentiment;
  final List<Suggestion> suggestions;

  static OtherDetail fromJson(Map<String, dynamic> jsonMap) {
    final suggestionsJson =
        (jsonMap['suggestions'] as List<Map<String, dynamic>>);
    return OtherDetail(
        UserMinimal.fromJson(jsonMap['user'] as Map<String, dynamic>),
        Sentiment.fromJson(jsonMap['sentiment'] as String),
        suggestionsJson
            .map((Map<String, dynamic> sugg) => Suggestion.fromJson(sugg))
            .toList(growable: false));
  }

  OtherDetail(this.user, this.sentiment, this.suggestions);
}
