import 'package:flutter/cupertino.dart';
import 'package:stimmungsringeapp/pages/dashboard/dashboard_page.dart';
import 'package:stimmungsringeapp/pages/onboarding/onboarding_page.dart';
import 'package:stimmungsringeapp/pages/other_detail/other_detail_page.dart';
import 'package:stimmungsringeapp/pages/routing_error_page.dart';
import 'package:stimmungsringeapp/pages/set_my_sentiment_page.dart';
import 'package:stimmungsringeapp/repositories/dashboard_repository.dart';
import 'package:stimmungsringeapp/repositories/repositories.dart';

void main() {
  // TODO: throws exceptions on start
//  SystemChrome.setPreferredOrientations(
//      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  // https://bloclibrary.dev/#/flutterweathertutorial?id=repository

  final DashboardRepository dashboardRepository = DashboardRepository();
  final OnboardingRepository onboardingRepository = new OnboardingRepository();

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
      initialRoute: OnboardingPage.routeUri,
      routes: Map.fromEntries([
        OnboardingPage.makeRoute(onboardingRepository),
        DashboardPage.makeRoute(dashboardRepository),
        SetMySentimentPage.route,
        OtherDetailPage.makeRoute(dashboardRepository),
      ]),
      onUnknownRoute: (_) =>
          CupertinoPageRoute<Widget>(builder: (context) => RoutingErrorPage()),
    );
  }
}
