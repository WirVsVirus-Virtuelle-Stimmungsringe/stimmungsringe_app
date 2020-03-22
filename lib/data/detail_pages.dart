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
  String text;

  Suggestion.fromJson(Map<String, dynamic> jsonMap) {
    this.text = jsonMap['text'];
  }
}

class OtherDetail {
  UserMinimal user;
  SentimentStatus sentimentStatus;
  List<Suggestion> suggestions;

  OtherDetail.fromJson(Map<String, dynamic> jsonMap) {
    this.user = UserMinimal.fromJson(jsonMap['user']);
    this.sentimentStatus = SentimentStatus.fromJson(jsonMap['sentimentStatus']);

    final suggestionsJson = (jsonMap['suggestions'] as List);
    this.suggestions = suggestionsJson
        .map((sugg) => Suggestion.fromJson(sugg))
        .toList(growable: false);
  }
}
