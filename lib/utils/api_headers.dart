import 'package:familiarise/config.dart';

Map<String, String> public() {
  return {
    'X-FAM-Proxy-Key': Config().proxyKey,
  };
}

Map<String, String> authenticated(String userId) {
  return {
    ...public(),
    'X-User-ID': userId,
  };
}
