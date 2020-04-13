import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:stimmungsringeapp/pages/onboarding/bloc/bloc.dart';
import 'package:stimmungsringeapp/pages/onboarding/onboarding_create_group_page.dart';
import 'package:stimmungsringeapp/repositories/onboarding_repository.dart';
import 'package:stimmungsringeapp/widgets/action_button.dart';
import 'package:stimmungsringeapp/widgets/button_group.dart';
import 'package:stimmungsringeapp/widgets/familiarise_logo.dart';
import 'package:stimmungsringeapp/widgets/loading_spinner.dart';

class OnboardingStartPage extends StatefulWidget {
  static const String routeUri = '/';

  const OnboardingStartPage({Key key}) : super(key: key);

  static MapEntry<String, WidgetBuilder> makeRoute(
          OnboardingRepository onboardingRepository) =>
      MapEntry(
        routeUri,
        (_) => BlocProvider<OnboardingBloc>(
          create: (_) =>
              OnboardingBloc(onboardingRepository: onboardingRepository),
          child: const OnboardingStartPage(),
        ),
      );

  @override
  _OnboardingStartPageState createState() => _OnboardingStartPageState();
}

class _OnboardingStartPageState extends State<OnboardingStartPage> {
  final _groupSearchCodeController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    BlocProvider.of<OnboardingBloc>(context).add(CheckUserEvent());
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        child: SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: BlocConsumer<OnboardingBloc, OnboardingState>(
          builder: (context, state) {
            if (state is CheckingUserState) {
              return buildLoadingPage();
            }

            if (state is FindGroupState) {
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

            if (state is FindGroupSearchingState) {
              return LoadingSpinner();
            }

            if (state is GroupFoundState) {
              // return buildSuccessArea(context);
            }

            return Column(
              children: <Widget>[
                const FamiliariseLogo(),
                ButtonGroup(
                  children: <Widget>[
                    ActionButton(
                      text: const Text('Meine Fam-Group starten'),
                      onPressed: () {
                        final OnboardingBloc onboardingBloc =
                            BlocProvider.of<OnboardingBloc>(context)
                              ..add(ShowCreateNewGroupFormEvent());

                        Navigator.pushNamed(
                          context,
                          OnboardingCreateGroupPage.routeUri,
                          arguments: onboardingBloc,
                        );
                      },
                    ),
                    ActionButton(
                      onPressed: () => BlocProvider.of<OnboardingBloc>(context)
                          .add(ShowJoinGroupFormEvent()),
                      text: const Text('Fam-Group Code eingeben'),
                    ),
                  ],
                ),
              ],
            );
          },
          listener: (context, state) {
            if (state is NoOnboardingRequiredState) {
              print("navigate from onboarding to dasboard");
              Navigator.of(context).pushReplacementNamed('/home');
            }

            if (state is GroupFoundState) {
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

            if (state is GroupNotFoundState) {
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

  /// atm searching by group name
  void _searchGroupByCode(String code) {
    BlocProvider.of<OnboardingBloc>(context).add(SearchGroupEvent(code));
  }

  Widget buildLoadingPage() {
    return LoadingSpinner();
  }

  Widget _errorPage(BuildContext context, OnboardingState state) {
    print("Did not render state $state");
    return LoadingSpinner();
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
