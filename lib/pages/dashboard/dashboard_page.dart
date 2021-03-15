import 'dart:math';

import 'package:familiarise/data/dashboard.dart';
import 'package:familiarise/data/group_data.dart';
import 'package:familiarise/data/user_minimal.dart';
import 'package:familiarise/pages/dashboard/bloc/dashboard_bloc.dart';
import 'package:familiarise/pages/dashboard/bloc/dashboard_event.dart';
import 'package:familiarise/pages/dashboard/bloc/dashboard_state.dart';
import 'package:familiarise/pages/group_settings/group_settings_page.dart';
import 'package:familiarise/pages/inbox/inbox_page.dart';
import 'package:familiarise/pages/other_detail/other_detail_page.dart';
import 'package:familiarise/pages/set_my_sentiment_page.dart';
import 'package:familiarise/pages/user_settings/bloc/user_settings_bloc.dart';
import 'package:familiarise/pages/user_settings/user_settings_page.dart';
import 'package:familiarise/repositories/dashboard_repository.dart';
import 'package:familiarise/repositories/message_repository.dart';
import 'package:familiarise/widgets/avatar_row.dart';
import 'package:familiarise/widgets/avatar_row_condensed.dart';
import 'package:familiarise/widgets/headline.dart';
import 'package:familiarise/widgets/loading_spinner.dart';
import 'package:familiarise/widgets/paragraph.dart';
import 'package:familiarise/widgets/protected_network_image.dart';
import 'package:familiarise/widgets/share_group_code.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardPage extends StatefulWidget {
  static const String routeUri = '/home';

  static MapEntry<String, WidgetBuilder> makeRoute(
      UserSettingsBloc userSettingsBloc) {
    return MapEntry(
      routeUri,
      _makeRouteBuilder(userSettingsBloc),
    );
  }

  static PageRouteBuilder<Widget> makeRouteWithoutTransition(
      UserSettingsBloc userSettingsBloc) {
    return PageRouteBuilder<Widget>(
        pageBuilder: (context, animation1, animation2) =>
            _makeRouteBuilder(userSettingsBloc)(context));
  }

  static WidgetBuilder _makeRouteBuilder(UserSettingsBloc userSettingsBloc) {
    return (BuildContext c) => BlocProvider<DashboardBloc>(
          create: (context) => DashboardBloc(
            dashboardRepository: DashboardRepository(),
            messageRepository: MessageRepository(),
            userSettingsBloc: userSettingsBloc,
          ),
          child: DashboardPage(),
        );
  }

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  /// https://api.flutter.dev/flutter/widgets/WidgetsBindingObserver-class.html
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      BlocProvider.of<DashboardBloc>(context).add(FetchDashboard());
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    BlocProvider.of<DashboardBloc>(context).add(FetchDashboard());
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: buildNavigationBar(context),
      child: SafeArea(
        bottom: false,
        child: BlocBuilder<DashboardBloc, DashboardState>(
          builder: (context, state) {
            if (!state.hasDashboard) {
              return LoadingSpinner();
            }

            final StateWithData stateWithData = state as StateWithData;

            return Column(
              children: <Widget>[
                _avatarRow(stateWithData),
                Expanded(
                  child: buildDashboardBody(stateWithData),
                )
              ],
            );
          },
        ),
      ),
    );
  }

  CupertinoNavigationBar buildNavigationBar(BuildContext context) {
    return CupertinoNavigationBar(
      middle: const Text('Übersicht'),
      trailing: GestureDetector(
        onTap: () => Navigator.pushNamed(
          context,
          GroupSettingsPage.routeUri,
        ),
        child: const Icon(
          CupertinoIcons.gear,
          color: CupertinoColors.activeBlue,
        ),
      ),
    );
  }

  Widget _avatarRow(StateWithData stateWithData) {
    final Dashboard dashboard = stateWithData.dashboard;
    final String nameInRow = dashboard.myTile.user.hasName
        ? dashboard.myTile.user.displayName
        : 'Namen ändern...';

    final UserMinimal user = dashboard.myTile.user;
    return AvatarRow(
      name: nameInRow,
      image: makeProtectedNetworkImage(
        user.userId,
        user.avatarUrl,
      ),
      avatarSentiment: dashboard.myTile.sentiment,
      onAvatarImageTap: () {
        Navigator.pushNamed(
          context,
          UserSettingsPage.routeUri,
        );
      },
      onSentimentIconTap: () {
        Navigator.pushNamed(
          context,
          SetMySentimentPage.routeUri,
          arguments: BlocProvider.of<DashboardBloc>(context),
        );
      },
      inboxMessageCount: min(stateWithData.inbox.messages.length, 99),
      onInboxIconTap: () {
        if (stateWithData.inbox.messages.isNotEmpty) {
          Navigator.pushNamed(context, InboxPage.routeUri, arguments: {
            'dashboardBloc': BlocProvider.of<DashboardBloc>(context),
          });
        }
      },
    );
  }

  Padding buildDashboardBody(StateWithData stateWithData) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: stateWithData.dashboard.otherTiles.isEmpty
          ? _emptyGroupInfo(
              stateWithData.dashboard.groupData,
            )
          : _contactList(
              stateWithData.dashboard,
              stateWithData.now,
            ),
    );
  }

  Widget _emptyGroupInfo(GroupData groupData) {
    if (groupData == null) {
      return Container();
    }

    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 16, bottom: 8),
          child: Column(
            children: [
              const Paragraph(
                child: Headline('Fam-Group erfolgreich erstellt!'),
              ),
              const Paragraph(
                child: Text(
                    'Teile den Code mit den Leuten, die du in die Fam-Group einladen willst.',
                    textAlign: TextAlign.center),
              ),
              const Paragraph(
                child: Text(
                  'Einladungs-Code der Fam-Group:',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              ShareGroupCode(
                groupCode: groupData.groupCode,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _contactList(Dashboard dashboard, DateTime now) {
    return Column(
      children: <Widget>[
        Paragraph(
          child: Headline('Fam-Group "${dashboard.groupData.groupName}"'),
        ),
        Expanded(
          child: Paragraph(
            isLastWidget: true,
            child: ListView(
              children: _otherTiles(context, dashboard, now),
            ),
          ),
        )
      ],
    );
  }

  List<Widget> _otherTiles(
      BuildContext context, Dashboard dashboard, DateTime now) {
    return dashboard.otherTiles.map(
      (tile) {
        final String contactName = tile.user.hasName
            ? tile.user.displayName
            : 'Kontakt hat noch keinen Namen vergeben 😟';

        return Container(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: GestureDetector(
            onTap: () => Navigator.pushNamed(
              context,
              OtherDetailPage.routeUri,
              arguments: {
                'dashboardBloc': BlocProvider.of<DashboardBloc>(context),
                'otherUserId': tile.user.userId,
              },
            ),
            child: AvatarRowCondensed(
              name: contactName,
              image: makeProtectedNetworkImage(
                tile.user.userId,
                tile.user.avatarUrl,
              ),
              avatarSentiment: tile.sentiment,
              lastStatusUpdate: tile.lastStatusUpdate,
              now: now,
            ),
          ),
        );
      },
    ).toList(growable: false);
  }
}
