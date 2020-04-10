import 'package:flutter/cupertino.dart';
import 'package:stimmungsringeapp/repositories/dashboard_repository.dart';
import 'package:stimmungsringeapp/routing.dart';

void main() {
  // TODO: throws exceptions on start
//  SystemChrome.setPreferredOrientations(
//      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  // https://bloclibrary.dev/#/flutterweathertutorial?id=repository

  final DashboardRepository dashboardRepository = DashboardRepository();
  runApp(SentimentApp(dashboardRepository: dashboardRepository));
}

class SentimentApp extends StatelessWidget {
  final DashboardRepository dashboardRepository;

  const SentimentApp({this.dashboardRepository});

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'Stimmungsringe',
      onGenerateRoute: (RouteSettings settings) =>
          RouteGenerator.generateRoute(settings, dashboardRepository),
    );
  }
}
