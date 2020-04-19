import 'package:flutter_udid/flutter_udid.dart';
import 'package:stimmungsringeapp/global_constants.dart';

String currentUserId;
String currentGroupId;

Future<String> getCurrentDeviceIdentifier() async {
  if (forceOnboarding) {
    return '0000';
  } else {
    return FlutterUdid.consistentUdid;
  }
}
