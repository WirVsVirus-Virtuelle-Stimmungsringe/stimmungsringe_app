import 'package:familiarise/config.dart';
import 'package:familiarise/pages/about/about_page.dart';
import 'package:familiarise/pages/dashboard/dashboard_page.dart';
import 'package:familiarise/pages/group_settings/group_settings_page.dart';
import 'package:familiarise/pages/inbox/inbox_page.dart';
import 'package:familiarise/pages/onboarding/onboarding_create_group_page.dart';
import 'package:familiarise/pages/onboarding/onboarding_join_group_page.dart';
import 'package:familiarise/pages/onboarding/onboarding_start_page.dart';
import 'package:familiarise/pages/other_detail/other_detail_page.dart';
import 'package:familiarise/pages/routing_error_page.dart';
import 'package:familiarise/pages/set_my_sentiment_page.dart';
import 'package:familiarise/pages/user_settings/bloc/user_settings_bloc.dart';
import 'package:familiarise/pages/user_settings/user_settings_page.dart';
import 'package:familiarise/push_notifications.dart';
import 'package:familiarise/repositories/avatar_repository.dart';
import 'package:familiarise/repositories/onboarding_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

 PushNotificationsManager? pushNotificationsManager;

Future<void> main() async {
  await Config().loaded;

  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
  );

  pushNotificationsManager = PushNotificationsManager();
  await pushNotificationsManager!.init();

  final UserSettingsBloc userSettingsBloc =
      UserSettingsBloc(OnboardingRepository(), AvatarRepository());

  runApp(
    SentimentApp(
      userSettingsBloc: userSettingsBloc,
    ),
  );
}

class SentimentApp extends StatefulWidget {
  final UserSettingsBloc userSettingsBloc;

  const SentimentApp({
    required this.userSettingsBloc,
  });

  @override
  // ignore: no_logic_in_create_state
  State<StatefulWidget> createState() => _SentimentAppState(userSettingsBloc);
}

/// All of the StatefulWidget and WidgetsBindingObserver stuff is only necessary
/// to work around https://github.com/flutter/flutter/issues/48438, as soon as
/// it's fixed we should remove all of this cruft.
class _SentimentAppState extends State<SentimentApp>
    with WidgetsBindingObserver {
  final UserSettingsBloc userSettingsBloc;
  CupertinoThemeData? theme;

  _SentimentAppState(this.userSettingsBloc) : super();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
    didChangePlatformBrightness();
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangePlatformBrightness() {
    final Brightness brightness =
        WidgetsBinding.instance!.window.platformBrightness;

    setState(() {
      theme = CupertinoThemeData(brightness: brightness);
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'Familiarise',
      initialRoute: OnboardingStartPage.routeUri,
      theme: theme,
      debugShowCheckedModeBanner: Config().debug,
      routes: Map.fromEntries([
        OnboardingStartPage.makeRoute(userSettingsBloc),
        OnboardingCreateGroupPage.route,
        OnboardingJoinGroupPage.route,
        DashboardPage.makeRoute(userSettingsBloc),
        SetMySentimentPage.route,
        OtherDetailPage.makeRoute(),
        GroupSettingsPage.makeRoute(),
        UserSettingsPage.makeRoute(userSettingsBloc),
        InboxPage.makeRoute(),
        AboutPage.makeRoute(),
      ]),
      onUnknownRoute: (_) =>
          CupertinoPageRoute<Widget>(builder: (context) => RoutingErrorPage()),
    );
  }
}
