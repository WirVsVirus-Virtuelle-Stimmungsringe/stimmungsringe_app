import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:stimmungsringeapp/pages/dashboard/dashboard_page.dart';
import 'package:stimmungsringeapp/pages/onboarding/bloc/bloc.dart';
import 'package:stimmungsringeapp/widgets/action_button.dart';
import 'package:stimmungsringeapp/widgets/button_group.dart';
import 'package:stimmungsringeapp/widgets/familiarise_logo.dart';
import 'package:stimmungsringeapp/widgets/paragraph.dart';
import 'package:stimmungsringeapp/widgets/wait_dialog.dart';

class OnboardingJoinGroupPage extends StatefulWidget {
  static const String routeUri = '/onboarding/join-group';

  const OnboardingJoinGroupPage({Key key}) : super(key: key);

  static MapEntry<String, WidgetBuilder> route = MapEntry(
    routeUri,
    (BuildContext context) => BlocProvider.value(
      value: ModalRoute.of(context).settings.arguments as OnboardingBloc,
      child: const OnboardingJoinGroupPage(),
    ),
  );

  @override
  _OnboardingJoinGroupPageState createState() =>
      _OnboardingJoinGroupPageState();
}

class _OnboardingJoinGroupPageState extends State<OnboardingJoinGroupPage> {
  final _groupCodeController = TextEditingController();
  bool waitDialogVisible = false;

  @override
  void initState() {
    super.initState();

    _groupCodeController.addListener(() => setState(() {}));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    BlocProvider.of<OnboardingBloc>(context).add(ShowJoinGroupFormEvent());
  }

  @override
  Widget build(BuildContext context) {
    final submitButtonHandler = _isGroupCodeValid()
        ? () => _joinGroupByCode(_groupCodeController.text)
        : null;

    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: SingleChildScrollView(
            child: BlocConsumer<OnboardingBloc, OnboardingState>(
              builder: (context, state) {
                return Column(
                  children: <Widget>[
                    const FamiliariseLogo(),
                    const Paragraph(
                      child: Text(
                        'Trete deiner Fam-Group bei, um direkt und einfach ein '
                        'Gespür für die Stimmungslage der Mitglieder zu bekommen.\n'
                        'Es sind keine langen Gespräche oder Interpretationen nötig.',
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const Paragraph(
                      child: Text(
                        'Du kannst einfach da sein und Acht geben!',
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Paragraph(
                      child: CupertinoTextField(
                        placeholder: "Kennst du den Fam-Group Code?",
                        controller: _groupCodeController,
                        onSubmitted: _joinGroupByCode,
                        autofocus: true,
                      ),
                    ),
                    Paragraph(
                      child: ButtonGroup(
                        children: [
                          ActionButton(
                            onPressed: submitButtonHandler,
                            text: const Text('beitreten'),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
              listener: (context, state) {
                if (state is JoinGroupPendingState) {
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

                if (state is JoinedGroupState) {
                  print("show alert: joined group ${state.groupName}");

                  Future.delayed(const Duration(milliseconds: 800), () {
                    Fluttertoast.showToast(
                        msg: "Erfolgreich beigetreten",
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

                if (state is GroupNotFoundState) {
                  print("show alert: Group not found!");
                  _groupCodeController.clear();

                  Future.delayed(const Duration(milliseconds: 800), () {
                    Fluttertoast.showToast(
                        msg: "Gruppe nicht gefunden",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: CupertinoColors.destructiveRed,
                        textColor: CupertinoColors.white,
                        fontSize: 16.0);
                  });
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  bool _isGroupCodeValid() {
    return _groupCodeController.text.length >= 3;
  }

  void _joinGroupByCode(String groupCode) {
    if (_isGroupCodeValid()) {
      BlocProvider.of<OnboardingBloc>(context).add(JoinGroupEvent(groupCode));
    }
  }
}
