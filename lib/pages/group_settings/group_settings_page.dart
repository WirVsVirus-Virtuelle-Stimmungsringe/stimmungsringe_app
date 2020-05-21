import 'package:familiarise/pages/group_settings/bloc/group_settings_bloc.dart';
import 'package:familiarise/pages/group_settings/bloc/group_settings_event.dart';
import 'package:familiarise/pages/group_settings/bloc/group_settings_state.dart';
import 'package:familiarise/pages/loading_spinner_page.dart';
import 'package:familiarise/pages/onboarding/onboarding_start_page.dart';
import 'package:familiarise/repositories/onboarding_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GroupSettingsPage extends StatefulWidget {
  static const String routeUri = '/group-settings';

  static MapEntry<String, WidgetBuilder> makeRoute() => MapEntry(
        routeUri,
        (BuildContext c) => BlocProvider<GroupSettingsBloc>(
          create: (context) => GroupSettingsBloc(OnboardingRepository()),
          child: GroupSettingsPage(),
        ),
      );

  @override
  _GroupSettingsPageState createState() => _GroupSettingsPageState();
}

class _GroupSettingsPageState extends State<GroupSettingsPage> {
  final _groupNameController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    BlocProvider.of<GroupSettingsBloc>(context).add(LoadSettings());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GroupSettingsBloc, GroupSettingsState>(
      builder: (context, state) {
        if (state is GroupSettingsLoading) {
          return LoadingSpinnerPage();
        }
        if (state is ShowCurrentGroupSettings) {
          _groupNameController.text = state.groupName;
          return WillPopScope(
            onWillPop: () {
              BlocProvider.of<GroupSettingsBloc>(context)
                  .add(SaveGroupSettings(groupName: _groupNameController.text));
              return Future.value(true);
            },
            child: CupertinoPageScaffold(
              navigationBar: const CupertinoNavigationBar(
                middle: Text('Einstellungen Fam-Group'),
              ),
              child: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(state.groupName),
                    CupertinoTextField(
                      controller: _groupNameController,
                    ),
                    Text("Code für die Fam-Group: ${state.groupCode}"),
                    CupertinoButton(
                      onPressed: () {
                        BlocProvider.of<GroupSettingsBloc>(context)
                            .add(LeaveGroup());
                      },
                      child: const Text("leave group"),
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        print("Not rendering state in group settings page ${state.toString()}");
        return LoadingSpinnerPage();
      },
      listener: (context, state) {
        if (state is GotoOnboarding) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            OnboardingStartPage.routeUri,
            (_) => false,
          );
        }
      },
    );
  }
}
