import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:stimmungsringeapp/pages/dashboard/dashboard_page.dart';
import 'package:stimmungsringeapp/pages/onboarding/bloc/onboarding_bloc.dart';
import 'package:stimmungsringeapp/pages/onboarding/bloc/onboarding_event.dart';
import 'package:stimmungsringeapp/pages/onboarding/bloc/onboarding_state.dart';
import 'package:stimmungsringeapp/widgets/action_button.dart';
import 'package:stimmungsringeapp/widgets/button_group.dart';
import 'package:stimmungsringeapp/widgets/familiarise_logo.dart';
import 'package:stimmungsringeapp/widgets/headline.dart';
import 'package:stimmungsringeapp/widgets/paragraph.dart';
import 'package:stimmungsringeapp/widgets/wait_dialog.dart';

class OnboardingCreateGroupPage extends StatefulWidget {
  static const String routeUri = '/onboarding/create-group';

  const OnboardingCreateGroupPage({Key key}) : super(key: key);

  static MapEntry<String, WidgetBuilder> route = MapEntry(
    routeUri,
    (BuildContext context) => BlocProvider.value(
      value: ModalRoute.of(context).settings.arguments as OnboardingBloc,
      child: const OnboardingCreateGroupPage(),
    ),
  );

  @override
  _OnboardingCreateGroupPageState createState() =>
      _OnboardingCreateGroupPageState();
}

class _OnboardingCreateGroupPageState extends State<OnboardingCreateGroupPage> {
  final _newGroupNameController = TextEditingController();
  bool waitDialogVisible = false;

  @override
  void initState() {
    super.initState();

    _newGroupNameController.addListener(() => setState(() {}));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    BlocProvider.of<OnboardingBloc>(context).add(ShowCreateNewGroupFormEvent());
  }

  @override
  Widget build(BuildContext context) {
    final submitButtonHandler = _isGroupNameValid()
        ? () => _startNewGroup(_newGroupNameController.text)
        : null;

    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: BlocConsumer<OnboardingBloc, OnboardingState>(
            builder: (context, state) {
              return SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    const FamiliariseLogo(),
                    const Paragraph(
                      child:
                          Headline('Vergebe einen Namen für deine Fam-Group'),
                    ),
                    Paragraph(
                      child: CupertinoTextField(
                        placeholder: "Wie soll die neue Gruppe heißen?",
                        controller: _newGroupNameController,
                        onSubmitted: _startNewGroup,
                        autofocus: true,
                      ),
                    ),
                    Paragraph(
                      child: ButtonGroup(
                        children: [
                          ActionButton(
                            text: const Text('Fam-Group starten'),
                            onPressed: submitButtonHandler,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
            listener: (context, state) {
              if (state is CreateNewGroupPendingState) {
                if (!waitDialogVisible) {
                  showCupertinoDialog<void>(
                    context: context,
                    builder: (_) => const WaitDialog(),
                  );
                  waitDialogVisible = true;
                }
              } else {
                if (waitDialogVisible) {
                  Navigator.of(context).pop();
                  waitDialogVisible = false;
                }
              }

              if (state is NewGroupCreatedState) {
                print("show alert: Started new Group ${state.groupName}");

                Future.delayed(const Duration(milliseconds: 800), () {
                  Fluttertoast.showToast(
                      msg: "Erfolgreich erstellt",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: CupertinoColors.activeGreen,
                      textColor: CupertinoColors.white,
                      fontSize: 16.0);
                });

                Navigator.pushNamedAndRemoveUntil(
                  context,
                  DashboardPage.routeUri,
                  (_) => false,
                );
              }
            },
          ),
        ),
      ),
    );
  }

  bool _isGroupNameValid() {
    return _newGroupNameController.text.length >= 3;
  }

  void _startNewGroup(String groupName) {
    if (_isGroupNameValid()) {
      BlocProvider.of<OnboardingBloc>(context)
          .add(CreateNewGroupEvent(groupName));
    }
  }
}
