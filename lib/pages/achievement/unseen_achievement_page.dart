import 'package:familiarise/data/achievement.dart';
import 'package:familiarise/pages/dashboard/bloc/dashboard_bloc.dart';
import 'package:familiarise/pages/dashboard/bloc/dashboard_event.dart';
import 'package:familiarise/pages/dashboard/bloc/dashboard_state.dart';
import 'package:familiarise/session.dart';
import 'package:familiarise/widgets/avatar.dart';
import 'package:familiarise/widgets/protected_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class UnseenAchievementPage extends StatelessWidget {
  static const String routeUri = '/achievement';
  static const _colorTransparent = Color(0x00000000);

  static MapEntry<String, WidgetBuilder> makeRoute() =>
      MapEntry(routeUri, (BuildContext context) {
        final args =
            ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;

        return BlocProvider<DashboardBloc>.value(
          value: args!['dashboardBloc'] as DashboardBloc,
          child: UnseenAchievementPage(
            args['unseenAchievement'] as UnseenAchievement,
          ),
        );
      });

  final UnseenAchievement _unseenAchievement;

  const UnseenAchievementPage(this._unseenAchievement);

  @override
  Widget build(BuildContext context) {
    final achievement = _unseenAchievement.unseenAchievement;
    return WillPopScope(
      onWillPop: () {
        final DashboardBloc dashboardBloc =
            BlocProvider.of<DashboardBloc>(context);
        dashboardBloc.add(MarkAchievementAsSeen(achievement));
        return Future.value(true);
      },
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: achievement.gradientColors.asList(),
          ),
        ),
        child: CupertinoPageScaffold(
          backgroundColor: _colorTransparent,
          navigationBar: CupertinoNavigationBar(
            leading: CupertinoNavigationBarBackButton(
              color: CupertinoColors.white,
              // this onPressed is only needed to work around what seems to be an
              // issue in Flutter: when you navigate to this screen,
              // ModalRoute.of(context) may be null for a short period of time
              onPressed: () {
                Navigator.maybePop(context);
              },
            ),
            backgroundColor: _colorTransparent,
            border: Border.all(color: _colorTransparent, width: 0),
          ),
          child: SafeArea(
            child: _body(achievement),
          ),
        ),
      ),
    );
  }

  Widget _body(Achievement unseenAchievement) {
    return BlocBuilder<DashboardBloc, DashboardState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                child: _carouselEntry(context, unseenAchievement),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _carouselEntry(BuildContext context, Achievement unseenAchievement) {
    final double textPadding = MediaQuery.of(context).size.width / 6;

    return Column(
      children: [
        Text(
          unseenAchievement.headline,
          style: const TextStyle(
            fontSize: 35,
            fontWeight: FontWeight.bold,
            color: CupertinoColors.white,
          ),
          textAlign: TextAlign.center,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Avatar(
            image: makeProtectedNetworkImage(
              currentUserId,
              unseenAchievement.avatarUrl,
            ),
            size: 200,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: textPadding,
            right: textPadding,
            bottom: 12,
          ),
          child: Text(
            unseenAchievement.bodyText,
            style: const TextStyle(
              color: CupertinoColors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const FaIcon(
          FontAwesomeIcons.solidHeart,
          size: 60,
          color: CupertinoColors.white,
        ),
      ],
    );
  }
}
