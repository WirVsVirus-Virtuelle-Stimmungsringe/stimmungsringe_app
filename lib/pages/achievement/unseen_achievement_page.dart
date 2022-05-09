import 'package:familiarise/data/achievement.dart';
import 'package:familiarise/pages/dashboard/bloc/dashboard_bloc.dart';
import 'package:familiarise/pages/dashboard/bloc/dashboard_event.dart';
import 'package:familiarise/pages/dashboard/bloc/dashboard_state.dart';
import 'package:familiarise/session.dart';
import 'package:familiarise/widgets/avatar.dart';
import 'package:familiarise/widgets/protected_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UnseenAchievementPage extends StatelessWidget {
  static const String routeUri = '/achievement';

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
        child: SafeArea(
          child: _body(achievement),
        ),
      ),
    );
  }

  Widget _body(Achievement unseenAchievement) {
    return BlocBuilder<DashboardBloc, DashboardState>(
      builder: (context, state) {
        final double textPadding = MediaQuery.of(context).size.width / 6;

        return Column(
          children: [
            Flexible(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
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
                  Text(
                    unseenAchievement.pageIcon,
                    style: const TextStyle(fontSize: 50),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
              child: CupertinoButton(
                color: unseenAchievement.ackButtonColor,
                onPressed: () {
                  Navigator.maybePop(context);
                },
                child: Text(unseenAchievement.ackButtonText),
              ),
            )
          ],
        );
      },
    );
  }
}
