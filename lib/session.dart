import 'package:flutter_udid/flutter_udid.dart';
import 'package:stimmungsringeapp/config.dart';

String currentUserId;
String currentGroupId;

Future<String> getCurrentDeviceIdentifier() async {
  if (Config().useFakeDeviceId) {
    return Config().fakeDeviceId;
  } else {
    return FlutterUdid.consistentUdid;
  }
}
