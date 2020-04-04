import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:stimmungsringeapp/global_constants.dart';

import 'sentiment.dart';
import 'user.dart';

Future<OtherDetail> loadOtherDetailPageData(String userId) async {
  final String url = restUrlOtherStatus(userId);

  http.Response response = await http.get(
    url,
    headers: {'X-User-ID': sampleUserMutti},
  );

  //await new Future.delayed(const Duration(seconds: 1));

  var detailPage = OtherDetail.fromJson(json.decode(response.body));

  return detailPage;
}

class Suggestion {
  final String text;

  static fromJson(Map<String, dynamic> jsonMap) {
    return Suggestion(jsonMap['text']);
  }

  const Suggestion(this.text);
}

class OtherDetail {
  final UserMinimal user;
  final SentimentStatus sentimentStatus;
  final List<Suggestion> suggestions;

  static fromJson(Map<String, dynamic> jsonMap) {
    final suggestionsJson = (jsonMap['suggestions'] as List);
    return OtherDetail(
        UserMinimal.fromJson(jsonMap['user']),
        SentimentStatus.fromJson(jsonMap['sentimentStatus']),
        suggestionsJson
            .map((sugg) => Suggestion.fromJson(sugg))
            .toList(growable: false));
  }

  OtherDetail(this.user, this.sentimentStatus, this.suggestions);
}
