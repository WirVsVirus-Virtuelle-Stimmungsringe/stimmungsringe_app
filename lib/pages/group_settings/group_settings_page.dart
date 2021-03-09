import 'package:familiarise/pages/group_settings/bloc/group_settings_bloc.dart';
import 'package:familiarise/pages/group_settings/bloc/group_settings_event.dart';
import 'package:familiarise/pages/group_settings/bloc/group_settings_state.dart';
import 'package:familiarise/pages/loading_spinner_page.dart';
import 'package:familiarise/pages/onboarding/onboarding_start_page.dart';
import 'package:familiarise/repositories/onboarding_repository.dart';
import 'package:familiarise/widgets/about_link.dart';
import 'package:familiarise/widgets/familiarise_logo.dart';
import 'package:familiarise/widgets/full_size_scroll_area.dart';
import 'package:familiarise/widgets/paragraph.dart';
import 'package:familiarise/widgets/share_group_code.dart';
import 'package:flutter/cupertino.dart';
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
                middle: Text('Fam-Group Einstellungen'),
              ),
              child: SafeArea(
                bottom: false,
                child: FullSizeScrollArea(
                  builder: (context) => buildContent(state, context),
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

  Widget buildContent(ShowCurrentGroupSettings state, BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              children: [
                const FamiliariseLogo(
                  height: 200,
                ),
                const Paragraph(
                  child: Text(
                    'Dein FAMILIARISE Fam-Group Code lautet:',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                ShareGroupCode(
                  groupCode: state.groupCode,
                ),
                const Paragraph(
                  child: Text(
                    'Name der Fam-Group:',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Paragraph(
                    child: CupertinoTextField(
                      placeholder: "Wie soll die Fam-Group heißen?",
                      controller: _groupNameController,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Paragraph(child: AboutLink()),
        _buildLeaveGroupArea(context),
      ],
    );
  }

  Widget _buildLeaveGroupArea(BuildContext context) {
    final EdgeInsets safeAreaPadding = MediaQuery.of(context).padding;
    return Container(
      color: CupertinoColors.lightBackgroundGray,
      padding:
          EdgeInsets.only(left: 12, right: 12, bottom: safeAreaPadding.bottom),
      child: Column(
        children: <Widget>[
          const Paragraph(
            isFirstWidget: true,
            child: Text(
              'Diese Gruppe verlassen:',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: CupertinoColors.black, fontWeight: FontWeight.bold),
            ),
          ),
          CupertinoButton(
            borderRadius: BorderRadius.circular(12.0),
            color: CupertinoColors.white,
            onPressed: () {
              BlocProvider.of<GroupSettingsBloc>(context).add(LeaveGroup());
            },
            child: const Text(
              'Gruppe verlassen',
              style: TextStyle(
                color: Color(0xff951919),
              ),
            ),
          ),
          const Paragraph(
            child: Text(
              'Notiere dir den Fam-Group Code. Du kannst jederzeit wieder der Fam-Group mit diesem Code beitreten.',
              textAlign: TextAlign.center,
              style: TextStyle(color: CupertinoColors.black),
            ),
          ),
        ],
      ),
    );
  }
}
