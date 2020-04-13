import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:stimmungsringeapp/pages/onboarding/bloc/bloc.dart';
import 'package:stimmungsringeapp/repositories/onboarding_repository.dart';
import 'package:stimmungsringeapp/widgets/action_button.dart';
import 'package:stimmungsringeapp/widgets/button_group.dart';
import 'package:stimmungsringeapp/widgets/familiarise_logo.dart';
import 'package:stimmungsringeapp/widgets/loading_spinner_widget.dart';

class OnboardingPage extends StatefulWidget {
  static const String routeUri = '/';

  static MapEntry<String, WidgetBuilder> makeRoute(
          OnboardingRepository onboardingRepository) =>
      MapEntry(
        routeUri,
        (_) => BlocProvider<OnboardingBloc>(
          create: (_) =>
              OnboardingBloc(onboardingRepository: onboardingRepository),
          child: OnboardingPage(),
        ),
      );

  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final _newGroupNameController = TextEditingController();
  final _groupSearchCodeController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    BlocProvider.of<OnboardingBloc>(context).add(CheckUser());
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        child: SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: BlocConsumer<OnboardingBloc, OnboardingState>(
          builder: (context, state) {
            if (state is CheckingUser) {
              return buildLoadingPage();
            }

            if (state is OnboardingIntro) {
              return Column(
                children: <Widget>[
                  const FamiliariseLogo(),
                  ButtonGroup(
                    children: <Widget>[
                      ActionButton(
                        text: const Text('Meine Fam-Group starten'),
                        onPressed: () =>
                            BlocProvider.of<OnboardingBloc>(context)
                                .add(BeginStartNewGroup()),
                      ),
                      ActionButton(
                        onPressed: () =>
                            BlocProvider.of<OnboardingBloc>(context)
                                .add(BeginJoinGroup()),
                        text: const Text('Fam-Group Code eingeben'),
                      ),
                    ],
                  ),
                ],
              );
            }

            if (state is StartNewGroupInitial) {
              return Column(
                children: <Widget>[
                  const FamiliariseLogo(),
                  CupertinoTextField(
                    placeholder: "Wie soll die neue Gruppe heißen?",
                    controller: _newGroupNameController,
                  ),
                  ActionButton(
                    onPressed: () =>
                        _startNewGroup(_newGroupNameController.text),
                    text: const Text('Fam-Group starten'),
                  ),
                ],
              );
            }

            if (state is FindGroupInitial) {
              return Column(
                children: <Widget>[
                  const FamiliariseLogo(),
                  CupertinoTextField(
                    placeholder: "Gib den Gruppen-Code ein (Tip: 12345)",
                    controller: _groupSearchCodeController,
                    onSubmitted: _searchGroupByCode,
                  ),
                  ActionButton(
                    onPressed: () =>
                        _searchGroupByCode(_groupSearchCodeController.text),
                    text: const Text('beitreten'),
                  ),
                ],
              );
            }

            if (state is FindGroupSearching) {
              return LoadingSpinnerWidget();
            }

            if (state is FindGroupSuccess) {
              // return buildSuccessArea(context);
            }

            // return _errorPage(context, state);

            print("Did not render state $state");
            return Container();
          },
          listener: (context, state) {
            if (state is GotoDashboard) {
              print("navigate from onboarding to dasboard");
              Navigator.of(context).pushReplacementNamed('/home');
            }

            if (state is StartNewGroupSuccess) {
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

              Navigator.of(context).pushReplacementNamed('/home');
            }

            if (state is StartNewGroupFailedConflict) {
              print("show alert: Group not created - name conflict!");
              _newGroupNameController.clear();

              Future.delayed(const Duration(milliseconds: 800), () {
                Fluttertoast.showToast(
                    msg: "Gruppe-Name schon in Verwendung",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: CupertinoColors.destructiveRed,
                    textColor: CupertinoColors.white,
                    fontSize: 16.0);
              });
            }

            if (state is FindGroupSuccess) {
              print("show alert: Group found ${state.groupName}");

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

              Navigator.of(context).pushReplacementNamed('/home');
            }

            if (state is FindGroupNotFound) {
              print("show alert: Group not found!");
              _groupSearchCodeController.clear();

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
    ));
  }

  void _startNewGroup(String groupName) {
    BlocProvider.of<OnboardingBloc>(context).add(StartNewGroup(groupName));
  }

  /// atm searching by group name
  void _searchGroupByCode(String code) {
    BlocProvider.of<OnboardingBloc>(context).add(SearchGroup(code));
  }

  Widget buildLoadingPage() {
    return LoadingSpinnerWidget();
  }

  Widget _errorPage(BuildContext context, OnboardingState state) {
    print("Did not render state $state");
    return LoadingSpinnerWidget();
    return CupertinoPageScaffold(
      child: SafeArea(
        child: Center(
          child: Column(
            children: <Widget>[
              const Text('Error'),
              CupertinoButton(
                onPressed: () => Navigator.pushNamed(
                  context,
                  "/",
                  arguments: null,
                ),
                child: const Text('zur Hauptseite'),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSuccessArea(BuildContext context) {
    return Column(
      children: <Widget>[
        const Text('Gruppe gefunden'),
        CupertinoButton(
          onPressed: () => Navigator.pushReplacementNamed(
            context,
            "/",
            arguments: null,
          ),
          child: const Text('Los legen!'),
        )
      ],
    );
  }
}
