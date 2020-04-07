import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stimmungsringeapp/pages/dashboard/bloc/bloc.dart';
import 'package:stimmungsringeapp/pages/dashboard/dashboard_page.dart';
import 'package:stimmungsringeapp/pages/other_detail/bloc/bloc.dart';
import 'package:stimmungsringeapp/pages/other_detail/other_detail_page.dart';
import 'package:stimmungsringeapp/pages/set_my_sentiment_page.dart';
import 'package:stimmungsringeapp/repositories/dashboard_repository.dart';

/**
 * see https://resocoder.com/2019/04/27/flutter-routes-navigation-parameters-named-routes-ongenerateroute/
 */
class RouteGenerator {
  static Route<dynamic> generateRoute(
      RouteSettings settings, DashboardRepository dashboardRepository) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return CupertinoPageRoute<DashboardPage>(
          builder: (_) => BlocProvider<DashboardBloc>(
            create: (context) =>
                DashboardBloc(dashboardRepository: dashboardRepository)
                  ..add(FetchDashboard()),
            child: DashboardPage(dashboardRepository: dashboardRepository),
          ),
        );
      case '/my-sentiment':
        if (args is MySentimentRouteArguments) {
          return CupertinoPageRoute<SetMySentimentPage>(
            builder: (context) {
              return BlocProvider.value(
                value: args.dashboardBloc,
                child: SetMySentimentPage(
                    dashboardRepository: dashboardRepository),
              );
            },
          );
        }
        return _errorRoute();
      case '/other-detail-page':
        if (args is OtherDetailRouteArguments) {
          return CupertinoPageRoute<SetMySentimentPage>(
            builder: (context) {
              return BlocProvider.value(
                value: args.dashboardBloc,
                child: BlocProvider<OtherDetailPageBloc>(
                  create: (context) => OtherDetailPageBloc()
                    ..add(
                      FetchOtherDetailPage(args.otherUserId),
                    ),
                  child:
                      OtherDetailPage(dashboardRepository: dashboardRepository),
                ),
              );
            },
          );
        }
        return _errorRoute();
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return CupertinoPageRoute<Widget>(builder: (_) {
      return CupertinoPageScaffold(
        child: SafeArea(
          child: Center(
            child: Container(
              child: Text('Routing Error'),
            ),
          ),
        ),
      );
    });
  }
}
