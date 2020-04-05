import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:stimmungsringeapp/data/freezed_classes.dart';
import 'package:stimmungsringeapp/global_constants.dart';

Future<Dashboard> loadDashboardPageData() async {
  final String url = restUrlDashboard();

  http.Response response = await http.get(
    url,
    headers: {'X-User-ID': sampleUserMutti},
  );

  var dashboard = Dashboard.fromJson(json.decode(response.body));

  return dashboard;
}
