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
  final UserRepository userRepository = new UserRepository();

  runApp(SentimentApp(
      userRepository: userRepository,
      dashboardRepository: dashboardRepository));
}

class SentimentApp extends StatelessWidget {
  final UserRepository userRepository;
  final DashboardRepository dashboardRepository;

  const SentimentApp({this.dashboardRepository, this.userRepository});

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'Stimmungsringe',
      onGenerateRoute: (RouteSettings settings) => RouteGenerator.generateRoute(
          settings,
          userRepository: userRepository,
          dashboardRepository: dashboardRepository),
    );
  }
}
