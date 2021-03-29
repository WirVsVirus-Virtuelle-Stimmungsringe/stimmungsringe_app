import 'package:familiarise/pages/dashboard/dashboard_page.dart';
import 'package:familiarise/pages/onboarding/bloc/onboarding_bloc.dart';
import 'package:familiarise/pages/onboarding/bloc/onboarding_event.dart';
import 'package:familiarise/pages/onboarding/bloc/onboarding_state.dart';
import 'package:familiarise/widgets/action_button.dart';
import 'package:familiarise/widgets/button_group.dart';
import 'package:familiarise/widgets/familiarise_logo.dart';
import 'package:familiarise/widgets/headline.dart';
import 'package:familiarise/widgets/paragraph.dart';
import 'package:familiarise/widgets/wait_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
  bool _waitDialogVisible = false;
  bool _codeSubmittedAtLeastOnce = false;

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
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: BlocConsumer<OnboardingBloc, OnboardingState>(
            builder: (context, state) {
              return Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Center(child: FamiliariseLogo()),
                          const Paragraph(
                            child: Center(
                              child: Headline(
                                'Tritt einer bestehenden Fam-Group bei!',
                              ),
                            ),
                          ),
                          const Paragraph(
                            child: Text(
                              'Gib dazu den dafür vorgesehen Fam-Group-Code ein:',
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Paragraph(
                            child: CupertinoTextField(
                              placeholder: "Einladungs-Code",
                              controller: _groupCodeController,
                              onSubmitted: _joinGroupByCode,
                              autofocus: true,
                            ),
                          ),
                          if (_codeSubmittedAtLeastOnce && !_isGroupCodeValid())
                            _makeInvalidCodeEnteredMessage()
                        ],
                      ),
                    ),
                  ),
                  Paragraph(
                    child: ButtonGroup(
                      children: [
                        ActionButton(
                          onPressed: _isGroupCodeValid()
                              ? () =>
                                  _joinGroupByCode(_groupCodeController.text)
                              : null,
                          text: const Text('Beitreten'),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
            listener: (context, state) {
              if (state is JoinGroupPendingState) {
                if (!_waitDialogVisible) {
                  showCupertinoDialog<void>(
                    context: context,
                    builder: (_) => const WaitDialog(),
                  );
                  _waitDialogVisible = true;
                }
              } else {
                if (_waitDialogVisible) {
                  Navigator.of(context).pop();
                  _waitDialogVisible = false;
                }
              }

              if (state is JoinedGroupState) {
                print("show alert: joined group ${state.groupName}");

                Future.delayed(const Duration(milliseconds: 800), () {
                  Fluttertoast.showToast(
                    msg: "Erfolgreich beigetreten",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    backgroundColor: CupertinoColors.activeGreen,
                    textColor: CupertinoColors.white,
                  );
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
                    backgroundColor: CupertinoColors.destructiveRed,
                    textColor: CupertinoColors.white,
                  );
                });
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _makeInvalidCodeEnteredMessage() {
    return const Paragraph(
      child: Text(
        'Der Fam-Group-Code ist eine sechsstellige Zahl',
        style: TextStyle(color: CupertinoColors.systemRed),
      ),
    );
  }

  bool _isGroupCodeValid() {
    return RegExp(r'^\d{6}$').hasMatch(_groupCodeController.text);
  }

  void _joinGroupByCode(String groupCode) {
    if (!_codeSubmittedAtLeastOnce) {
      setState(() => _codeSubmittedAtLeastOnce = true);
    }

    if (_isGroupCodeValid()) {
      BlocProvider.of<OnboardingBloc>(context).add(JoinGroupEvent(groupCode));
    }
  }
}
