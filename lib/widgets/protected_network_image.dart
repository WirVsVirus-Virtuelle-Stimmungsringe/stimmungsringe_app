import 'package:flutter/widgets.dart';

NetworkImage makeProtectedNetworkImage(String userId, String url,
    {Map<String, String> headers}) {
  final allHeaders = {
    ...?headers,
    ...{'X-User-ID': userId}
  };

  return NetworkImage(url, headers: allHeaders);
}
