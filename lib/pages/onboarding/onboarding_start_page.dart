import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stimmungsringeapp/pages/onboarding/bloc/bloc.dart';
import 'package:stimmungsringeapp/pages/onboarding/onboarding_create_group_page.dart';
import 'package:stimmungsringeapp/pages/onboarding/onboarding_join_group_page.dart';
import 'package:stimmungsringeapp/repositories/onboarding_repository.dart';
import 'package:stimmungsringeapp/widgets/action_button.dart';
import 'package:stimmungsringeapp/widgets/button_group.dart';
import 'package:stimmungsringeapp/widgets/familiarise_logo.dart';
import 'package:stimmungsringeapp/widgets/loading_spinner.dart';

class OnboardingStartPage extends StatelessWidget {
  static const String routeUri = '/';

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

  const OnboardingStartPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<OnboardingBloc>(context).add(CheckUserEvent());

    return CupertinoPageScaffold(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: BlocConsumer<OnboardingBloc, OnboardingState>(
            builder: (context, state) {
              if (state is CheckingUserState) {
                return LoadingSpinner();
              }

              return Column(
                children: <Widget>[
                  const FamiliariseLogo(),
                  ButtonGroup(
                    children: <Widget>[
                      ActionButton(
                        text: const Text('Meine Fam-Group starten'),
                        onPressed: () => Navigator.pushNamed(
                          context,
                          OnboardingCreateGroupPage.routeUri,
                          arguments: BlocProvider.of<OnboardingBloc>(context),
                        ),
                      ),
                      ActionButton(
                        onPressed: () => Navigator.pushNamed(
                          context,
                          OnboardingJoinGroupPage.routeUri,
                          arguments: BlocProvider.of<OnboardingBloc>(context),
                        ),
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
            },
          ),
        ),
      ),
    );
  }
}
