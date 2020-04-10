import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stimmungsringeapp/pages/dashboard/bloc/bloc.dart';
import 'package:stimmungsringeapp/pages/dashboard/dashboard_page.dart';
import 'package:stimmungsringeapp/pages/onboarding/bloc/bloc.dart';
import 'package:stimmungsringeapp/pages/onboarding/onboarding_page.dart';
import 'package:stimmungsringeapp/pages/other_detail/bloc/bloc.dart';
import 'package:stimmungsringeapp/pages/other_detail/other_detail_page.dart';
import 'package:stimmungsringeapp/pages/set_my_sentiment_page.dart';
import 'package:stimmungsringeapp/repositories/dashboard_repository.dart';
import 'package:stimmungsringeapp/repositories/repositories.dart';

/// see https://resocoder.com/2019/04/27/flutter-routes-navigation-parameters-named-routes-ongenerateroute/
class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings,
      {UserRepository userRepository,
      DashboardRepository dashboardRepository}) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;

    switch (settings.name) {
      case '/home':
        return CupertinoPageRoute<DashboardPage>(
          builder: (_) => BlocProvider<DashboardBloc>(
            create: (context) =>
                DashboardBloc(dashboardRepository: dashboardRepository),
            child: const DashboardPage(),
          ),
        );
      case '/my-sentiment':
        if (args is MySentimentRouteArguments) {
          return CupertinoPageRoute<SetMySentimentPage>(
            builder: (context) {
              return BlocProvider.value(
                value: args.dashboardBloc,
                child: const SetMySentimentPage(),
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
                  create: (context) => OtherDetailPageBloc(),
                  child: OtherDetailPage(
                    otherUserId: args.otherUserId,
                  ),
                ),
              );
            },
          );
        }
        return _errorRoute();
      case '/':
        return CupertinoPageRoute<OnboardingPage>(
          builder: (_) => BlocProvider<OnboardingBloc>(
            create: (_) => OnboardingBloc(userRepository: userRepository),
            child: OnboardingPage(),
          ),
        );
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return CupertinoPageRoute<Widget>(builder: (context) {
      return CupertinoPageScaffold(
        child: SafeArea(
          child: Center(
            child: Column(
              children: <Widget>[
                const Text('Routing Error'),
                CupertinoButton(
                  onPressed: () => Navigator.pushNamed(
                    context,
                    '/home',
                    arguments: null,
                  ),
                  child: const Text('zur Hauptseite'),
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
