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

  var detailPage = OtherDetail.fromJson(json.decode(response.body));

  await chaosMonkeyDelayAsync();
  return detailPage;
}

class Suggestion {
  final String text;

  static Suggestion fromJson(Map<String, dynamic> jsonMap) {
    return Suggestion(jsonMap['text']);
  }

  const Suggestion(this.text);
}

class OtherDetail {
  final UserMinimal user;
  final SentimentUi sentiment;
  final List<Suggestion> suggestions;

  static OtherDetail fromJson(Map<String, dynamic> jsonMap) {
    final suggestionsJson = (jsonMap['suggestions'] as List);
    return OtherDetail(
        UserMinimal.fromJson(jsonMap['user']),
        SentimentUi.fromJson(jsonMap['sentiment']),
        suggestionsJson
            .map((sugg) => Suggestion.fromJson(sugg))
            .toList(growable: false));
  }

  OtherDetail(this.user, this.sentiment, this.suggestions);
}
