import 'package:flutter/cupertino.dart';
import 'package:stimmungsringeapp/config.dart';
import 'package:stimmungsringeapp/pages/dashboard/dashboard_page.dart';
import 'package:stimmungsringeapp/pages/group_settings/group_settings_page.dart';
import 'package:stimmungsringeapp/pages/onboarding/onboarding_create_group_page.dart';
import 'package:stimmungsringeapp/pages/onboarding/onboarding_join_group_page.dart';
import 'package:stimmungsringeapp/pages/onboarding/onboarding_start_page.dart';
import 'package:stimmungsringeapp/pages/other_detail/other_detail_page.dart';
import 'package:stimmungsringeapp/pages/routing_error_page.dart';
import 'package:stimmungsringeapp/pages/set_my_sentiment_page.dart';
import 'package:stimmungsringeapp/pages/user_settings/user_settings_page.dart';
import 'package:stimmungsringeapp/repositories/dashboard_repository.dart';
import 'package:stimmungsringeapp/repositories/repositories.dart';

Future<void> main() async {
  // TODO: throws exceptions on start
//  SystemChrome.setPreferredOrientations(
//      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  // https://bloclibrary.dev/#/flutterweathertutorial?id=repository

  await Config().loaded;

  final DashboardRepository dashboardRepository = DashboardRepository();
  final OnboardingRepository onboardingRepository = OnboardingRepository();

  runApp(SentimentApp(
      onboardingRepository: onboardingRepository,
      dashboardRepository: dashboardRepository));
}

class SentimentApp extends StatelessWidget {
  final OnboardingRepository onboardingRepository;
  final DashboardRepository dashboardRepository;

  const SentimentApp({this.dashboardRepository, this.onboardingRepository});

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'Stimmungsringe',
      initialRoute: OnboardingStartPage.routeUri,
      routes: Map.fromEntries([
        OnboardingStartPage.makeRoute(
          onboardingRepository,
          dashboardRepository,
        ),
        OnboardingCreateGroupPage.route,
        OnboardingJoinGroupPage.route,
        DashboardPage.makeRoute(dashboardRepository),
        SetMySentimentPage.route,
        OtherDetailPage.makeRoute(dashboardRepository),
        GroupSettingsPage.makeRoute(onboardingRepository),
        UserSettingsPage.makeRoute(onboardingRepository),
      ]),
      onUnknownRoute: (_) =>
          CupertinoPageRoute<Widget>(builder: (context) => RoutingErrorPage()),
    );
  }
}
