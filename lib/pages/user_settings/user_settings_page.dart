import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stimmungsringeapp/pages/loading_spinner_page.dart';
import 'package:stimmungsringeapp/pages/onboarding/onboarding_start_page.dart';
import 'package:stimmungsringeapp/pages/user_settings/bloc/bloc.dart';

class UserSettingsPage extends StatefulWidget {
  static const String routeUri = '/user-settings';

  static MapEntry<String, WidgetBuilder> makeRoute(
          UserSettingsBloc userSettingsBloc) =>
      MapEntry(
        routeUri,
        (BuildContext c) => BlocProvider<UserSettingsBloc>.value(
          value: userSettingsBloc,
          child: UserSettingsPage(),
        ),
      );

  @override
  _UserSettingsPageState createState() => _UserSettingsPageState();
}

class _UserSettingsPageState extends State<UserSettingsPage> {
  final _userNameController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    BlocProvider.of<UserSettingsBloc>(context).add(LoadUserSettings());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserSettingsBloc, UserSettingsState>(
      builder: (context, state) {
        if (state is UserSettingsLoading) {
          return LoadingSpinnerPage();
        }
        if (state is ShowCurrentUserSettings) {
          _userNameController.text = state.userName;
          return WillPopScope(
            onWillPop: () {
              BlocProvider.of<UserSettingsBloc>(context)
                  .add(SaveUserSettings(userName: _userNameController.text));
              return Future.value(true);
            },
            child: CupertinoPageScaffold(
              navigationBar: const CupertinoNavigationBar(
                middle: Text('Einstellungen Benutzer'),
              ),
              child: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(state.hasName ? state.userName : 'kein Name vergeben'),
                    CupertinoTextField(
                      controller: _userNameController,
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        print("Not rendering state in user settings page ${state.toString()}");
        return LoadingSpinnerPage();
      },
      listener: (context, state) {
        if (state is GotoOnboarding) {
          Navigator.of(context)
              .pushReplacementNamed(OnboardingStartPage.routeUri);
        }
      },
    );
  }
}
