import 'package:familiarise/pages/dashboard/dashboard_page.dart';
import 'package:familiarise/pages/onboarding/bloc/onboarding_bloc.dart';
import 'package:familiarise/pages/onboarding/bloc/onboarding_event.dart';
import 'package:familiarise/pages/onboarding/bloc/onboarding_state.dart';
import 'package:familiarise/pages/onboarding/onboarding_create_group_page.dart';
import 'package:familiarise/pages/onboarding/onboarding_join_group_page.dart';
import 'package:familiarise/pages/user_settings/bloc/user_settings_bloc.dart';
import 'package:familiarise/repositories/onboarding_repository.dart';
import 'package:familiarise/widgets/about_link.dart';
import 'package:familiarise/widgets/action_button.dart';
import 'package:familiarise/widgets/button_group.dart';
import 'package:familiarise/widgets/familiarise_logo.dart';
import 'package:familiarise/widgets/headline.dart';
import 'package:familiarise/widgets/loading_spinner.dart';
import 'package:familiarise/widgets/paragraph.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnboardingStartPage extends StatelessWidget {
  static const String routeUri = '/';

  static MapEntry<String, WidgetBuilder> makeRoute(
          UserSettingsBloc userSettingsBloc) =>
      MapEntry(
        routeUri,
        (_) => BlocProvider<OnboardingBloc>(
          create: (_) =>
              OnboardingBloc(onboardingRepository: OnboardingRepository()),
          child: OnboardingStartPage(
            userSettingsBloc: userSettingsBloc,
          ),
        ),
      );

  final UserSettingsBloc userSettingsBloc;

  const OnboardingStartPage({Key key, @required this.userSettingsBloc})
      : assert(userSettingsBloc != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<OnboardingBloc>(context).add(CheckUserEvent());

    return CupertinoPageScaffold(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: BlocConsumer<OnboardingBloc, OnboardingState>(
            builder: (context, state) {
              if (state is CheckingUserState ||
                  state is NoOnboardingRequiredState) {
                return LoadingSpinner();
              }

              return Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          const FamiliariseLogo(),
                          const Paragraph(
                            child: Headline('Für ein achtsames Miteinander!'),
                          ),
                          const Paragraph(
                            child: Text(
                              'Passt auf euch auf und seid füreinander da.',
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Paragraph(
                            child: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                // Note: Styles for TextSpans must be explicitly defined.
                                // Child text spans will inherit styles from parent
                                style: DefaultTextStyle.of(context).style,
                                children: const <TextSpan>[
                                  TextSpan(
                                    text:
                                        'Mit der FAMILIARISE-App kannst du deine Stimmung mit deinem Umfeld teilen.',
                                  )
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 30, bottom: 30),
                            child: ButtonGroup(
                              children: <Widget>[
                                ActionButton(
                                  text: const Text('Meine Fam-Group starten'),
                                  onPressed: () => Navigator.pushNamed(
                                    context,
                                    OnboardingCreateGroupPage.routeUri,
                                    arguments: BlocProvider.of<OnboardingBloc>(
                                        context),
                                  ),
                                ),
                                ActionButton(
                                  onPressed: () => Navigator.pushNamed(
                                    context,
                                    OnboardingJoinGroupPage.routeUri,
                                    arguments: BlocProvider.of<OnboardingBloc>(
                                        context),
                                  ),
                                  text: const Text('Fam-Group-Code verwenden'),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  AboutLink(),
                ],
              );
            },
            listener: (context, state) {
              if (state is NoOnboardingRequiredState) {
                print("navigate from onboarding to dasboard");
                Navigator.of(context).pushReplacement(
                  DashboardPage.makeRouteWithoutTransition(
                    userSettingsBloc,
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
