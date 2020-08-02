import 'package:familiarise/config.dart';
import 'package:familiarise/pages/dashboard/dashboard_page.dart';
import 'package:familiarise/pages/group_settings/group_settings_page.dart';
import 'package:familiarise/pages/inbox/inbox_page.dart';
import 'package:familiarise/pages/onboarding/onboarding_create_group_page.dart';
import 'package:familiarise/pages/onboarding/onboarding_join_group_page.dart';
import 'package:familiarise/pages/onboarding/onboarding_start_page.dart';
import 'package:familiarise/pages/other_detail/other_detail_page.dart';
import 'package:familiarise/pages/routing_error_page.dart';
import 'package:familiarise/pages/set_my_sentiment_page.dart';
import 'package:familiarise/pages/user_settings/bloc/user_settings_bloc.dart';
import 'package:familiarise/pages/user_settings/user_settings_page.dart';
import 'package:familiarise/repositories/avatar_repository.dart';
import 'package:familiarise/repositories/onboarding_repository.dart';
import 'package:flutter/cupertino.dart';

Future<void> main() async {
  // TODO: throws exceptions on start
//  SystemChrome.setPreferredOrientations(
//      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  // https://bloclibrary.dev/#/flutterweathertutorial?id=repository

  await Config().loaded;

  final UserSettingsBloc userSettingsBloc =
      UserSettingsBloc(OnboardingRepository(), AvatarRepository());

  runApp(SentimentApp(
    userSettingsBloc: userSettingsBloc,
  ));
}

class SentimentApp extends StatelessWidget {
  final UserSettingsBloc userSettingsBloc;

  const SentimentApp({
    @required this.userSettingsBloc,
  }) : assert(userSettingsBloc != null);

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'Familiarise',
      initialRoute: OnboardingStartPage.routeUri,
      routes: Map.fromEntries([
        OnboardingStartPage.makeRoute(userSettingsBloc),
        OnboardingCreateGroupPage.route,
        OnboardingJoinGroupPage.route,
        DashboardPage.makeRoute(userSettingsBloc),
        SetMySentimentPage.route,
        OtherDetailPage.makeRoute(),
        GroupSettingsPage.makeRoute(),
        UserSettingsPage.makeRoute(userSettingsBloc),
        InboxPage.makeRoute(),
      ]),
      onUnknownRoute: (_) =>
          CupertinoPageRoute<Widget>(builder: (context) => RoutingErrorPage()),
    );
  }
}
