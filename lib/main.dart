import 'package:flutter/cupertino.dart';
import 'package:stimmungsringeapp/repositories/dashboard_repository.dart';
import 'package:stimmungsringeapp/repositories/repositories.dart';
import 'package:stimmungsringeapp/routing.dart';

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
      onGenerateRoute: (RouteSettings settings) => RouteGenerator.generateRoute(
          settings,
          onboardingRepository: onboardingRepository,
          dashboardRepository: dashboardRepository),
    );
  }
}
