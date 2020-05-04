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
import 'package:stimmungsringeapp/pages/user_settings/bloc/user_settings_bloc.dart';
import 'package:stimmungsringeapp/pages/user_settings/user_settings_page.dart';
import 'package:stimmungsringeapp/repositories/dashboard_repository.dart';
import 'package:stimmungsringeapp/repositories/onboarding_repository.dart';

Future<void> main() async {
  // TODO: throws exceptions on start
//  SystemChrome.setPreferredOrientations(
//      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  // https://bloclibrary.dev/#/flutterweathertutorial?id=repository

  await Config().loaded;

  final DashboardRepository dashboardRepository = DashboardRepository();
  final OnboardingRepository onboardingRepository = OnboardingRepository();
  final UserSettingsBloc userSettingsBloc =
      UserSettingsBloc(onboardingRepository);

  runApp(SentimentApp(
    onboardingRepository: onboardingRepository,
    dashboardRepository: dashboardRepository,
    userSettingsBloc: userSettingsBloc,
  ));
}

class SentimentApp extends StatelessWidget {
  final OnboardingRepository onboardingRepository;
  final DashboardRepository dashboardRepository;
  final UserSettingsBloc userSettingsBloc;

  const SentimentApp({
    @required this.dashboardRepository,
    @required this.onboardingRepository,
    @required this.userSettingsBloc,
  })  : assert(dashboardRepository != null),
        assert(onboardingRepository != null),
        assert(userSettingsBloc != null);

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'Stimmungsringe',
      initialRoute: OnboardingStartPage.routeUri,
      routes: Map.fromEntries([
        OnboardingStartPage.makeRoute(
            onboardingRepository, dashboardRepository, userSettingsBloc),
        OnboardingCreateGroupPage.route,
        OnboardingJoinGroupPage.route,
        DashboardPage.makeRoute(dashboardRepository, userSettingsBloc),
        SetMySentimentPage.route,
        OtherDetailPage.makeRoute(dashboardRepository),
        GroupSettingsPage.makeRoute(onboardingRepository),
        UserSettingsPage.makeRoute(userSettingsBloc),
      ]),
      onUnknownRoute: (_) =>
          CupertinoPageRoute<Widget>(builder: (context) => RoutingErrorPage()),
    );
  }
}
