import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stimmungsringeapp/pages/dashboard/bloc/bloc.dart';
import 'package:stimmungsringeapp/pages/dashboard/dashboard_page.dart';
import 'package:stimmungsringeapp/pages/other_detail/bloc/bloc.dart';
import 'package:stimmungsringeapp/pages/other_detail/other_detail_page.dart';
import 'package:stimmungsringeapp/pages/set_my_sentiment_page.dart';
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
              child: DashboardPage(dashboardRepository: dashboardRepository),
            ),
        'my-sentiment': (context) {
          final MySentimentRouteArguments arguments = (ModalRoute.of(context)
              .settings
              .arguments as MySentimentRouteArguments);
          return BlocProvider.value(
            value: arguments.dashboardBloc,
            child: SetMySentimentPage(dashboardRepository: dashboardRepository),
          );
        },
        'other-detail-page': (context) {
          final OtherDetailRouteArguments arguments = (ModalRoute.of(context)
              .settings
              .arguments as OtherDetailRouteArguments);
          return BlocProvider.value(
            value: arguments.dashboardBloc,
            child: BlocProvider<OtherDetailPageBloc>(
              create: (context) => OtherDetailPageBloc()
                ..add(
                  FetchOtherDetailPage(arguments.otherUserId),
                ),
              child: OtherDetailPage(dashboardRepository: dashboardRepository),
            ),
          );
        }
      },
    );
  }
}
