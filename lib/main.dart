import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stimmungsringeapp/pages/dashboard/bloc/bloc.dart';
import 'package:stimmungsringeapp/pages/dashboard/dashboard_page.dart';
import 'package:stimmungsringeapp/repositories/dashboard_repository.dart';

void main() {
  // TODO: throws exceptions on start
//  SystemChrome.setPreferredOrientations(
//      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  // https://bloclibrary.dev/#/flutterweathertutorial?id=repository

  final DashboardRepository dashboardRepository = new DashboardRepository();
  runApp(SentimentApp(dashboardRepository: dashboardRepository));
}

class SentimentApp extends StatelessWidget {
  final DashboardRepository dashboardRepository;

  SentimentApp({this.dashboardRepository});

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'Stimmungsringe',
      routes: {
        '/': (_) => BlocProvider<DashboardBloc>(
              create: (context) =>
                  DashboardBloc(dashboardRepository: dashboardRepository)
                    ..add(FetchDashboard()),
              child:
                  new DashboardPage(dashboardRepository: dashboardRepository),
            ),
        //'my-sentimentZZZ': (_) => SetMySentimentPage(
        //      dashboard: _dashboard,
        //      onSentimentChange: _updateMySentiment,
        //    ),
        //'other-detail-page': (context) => OtherDetailPage(
        //    dashboard: _dashboard,
        //    otherUserId: ModalRoute.of(context).settings.arguments)
      },
    );
  }
}
