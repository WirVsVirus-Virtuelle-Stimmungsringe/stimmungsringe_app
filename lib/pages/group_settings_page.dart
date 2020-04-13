import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stimmungsringeapp/pages/dashboard/bloc/bloc.dart';
import 'package:stimmungsringeapp/repositories/onboarding_repository.dart';

class GroupSettingsPage extends StatelessWidget {
  static const String routeUri = '/group-settings';

  static MapEntry<String, WidgetBuilder> makeRoute(
          OnboardingRepository onboardingRepository) =>
      MapEntry(
        routeUri,
        (context) => BlocProvider<DashboardBloc>.value(
          value: ModalRoute.of(context).settings.arguments as DashboardBloc,
          child: GroupSettingsPage(onboardingRepository: onboardingRepository),
        ),
      );

  GroupSettingsPage({@required OnboardingRepository onboardingRepository})
      : assert(onboardingRepository != null);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Einstellungen Fam-Group'),
      ),
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text("group settings"),
          ],
        ),
      ),
    );
  }
}
