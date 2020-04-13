import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stimmungsringeapp/pages/onboarding/bloc/bloc.dart';
import 'package:stimmungsringeapp/repositories/onboarding_repository.dart';
import 'package:stimmungsringeapp/session.dart';

class GroupSettingsPage extends StatelessWidget {
  static const String routeUri = '/group-settings';

  static MapEntry<String, WidgetBuilder> makeRoute(
          OnboardingRepository onboardingRepository) =>
      MapEntry(
        routeUri,
        (context) => BlocProvider<OnboardingBloc>.value(
          value: ModalRoute.of(context).settings.arguments as OnboardingBloc,
          child: GroupSettingsPage(),
        ),
      );

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
            CupertinoButton(
              child: Text("leave group"),
              onPressed: () {
                final OnboardingBloc onboardingBlock =
                    BlocProvider.of<OnboardingBloc>(context);
                onboardingBlock.add(LeaveGroup(currentGroupId));
              },
            ),
          ],
        ),
      ),
    );
  }
}
