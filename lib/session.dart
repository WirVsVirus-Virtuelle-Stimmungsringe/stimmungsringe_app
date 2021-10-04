import 'package:familiarise/config.dart';
import 'package:flutter_udid/flutter_udid.dart';

String currentUserId;
String currentGroupId;

Future<String/*!*/> getCurrentDeviceIdentifier() async {
  if (Config().useFakeDeviceId) {
    return Config().fakeDeviceId;
  } else {
    return FlutterUdid.consistentUdid;
  }
}
