import 'package:familiarise/config.dart';

Future<void> delayAsync() async {
  if (Config().chaosMonkeyEnabled) {
    await Future<void>.delayed(const Duration(milliseconds: 1000));
  }
}
