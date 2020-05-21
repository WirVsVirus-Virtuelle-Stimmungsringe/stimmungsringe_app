import 'package:familiarise/data/dashboard.dart';
import 'package:familiarise/data/group_data.dart';
import 'package:familiarise/data/user_minimal.dart';
import 'package:familiarise/pages/dashboard/bloc/dashboard_bloc.dart';
import 'package:familiarise/pages/dashboard/bloc/dashboard_event.dart';
import 'package:familiarise/pages/dashboard/bloc/dashboard_state.dart';
import 'package:familiarise/pages/group_settings/group_settings_page.dart';
import 'package:familiarise/pages/other_detail/other_detail_page.dart';
import 'package:familiarise/pages/set_my_sentiment_page.dart';
import 'package:familiarise/pages/user_settings/bloc/user_settings_bloc.dart';
import 'package:familiarise/pages/user_settings/user_settings_page.dart';
import 'package:familiarise/repositories/avatar_repository.dart';
import 'package:familiarise/repositories/dashboard_repository.dart';
import 'package:familiarise/widgets/avatar_row.dart';
import 'package:familiarise/widgets/avatar_row_condensed.dart';
import 'package:familiarise/widgets/headline.dart';
import 'package:familiarise/widgets/loading_spinner.dart';
import 'package:familiarise/widgets/paragraph.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share/share.dart';

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
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Übersicht'),
        trailing: GestureDetector(
          onTap: () => Navigator.pushNamed(
            context,
            GroupSettingsPage.routeUri,
          ),
          child: Icon(
            CupertinoIcons.gear,
            color: CupertinoColors.activeBlue,
          ),
        ),
      ),
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            _avatarRow(),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: _widgetWithDashboardBloc((stateWithDashboard) {
                  if (stateWithDashboard.dashboard.otherTiles.isEmpty) {
                    return _emptyGroupInfo(
                      stateWithDashboard.dashboard.groupData,
                    );
                  } else {
                    return _contactList(
                      stateWithDashboard.dashboard,
                      stateWithDashboard.now,
                    );
                  }
                }),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _emptyGroupInfo(GroupData groupData) {
    if (groupData == null) {
      return Container();
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        const Paragraph(
          child: Text(
            'Du hast leider noch keine Mitglieder in deiner Gruppe. Gebe doch '
            'einfach den Code an deine Angehörigen weiter.',
            textAlign: TextAlign.center,
          ),
        ),
        const Paragraph(
          child: Text(
            'Dein FAMILIARISE Fam-Group Code lautet:',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Paragraph(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                groupData.groupCode,
                style: const TextStyle(
                  color: Color.fromRGBO(0x95, 0x19, 0x19, 1),
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              CupertinoButton(
                onPressed: () {
                  Share.share(
                      'Trete bei FAMILIARISE der Fam-Group bei: ${groupData.groupCode}');
                },
                child: Icon(
                  CupertinoIcons.share,
                  color: CupertinoColors.link,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _avatarRow() {
    return _widgetWithDashboardBloc((stateWithDashboard) {
      final Dashboard dashboard = stateWithDashboard.dashboard;
      final String nameInRow = dashboard.myTile.user.hasName
          ? dashboard.myTile.user.displayName
          : 'Namen ändern...';

      final UserMinimal user = dashboard.myTile.user;
      return GestureDetector(
        onTap: () {
          print('AvatarRow open userSettings');
          Navigator.pushNamed(
            context,
            UserSettingsPage.routeUri,
          );
        },
        child: AvatarRow(
          name: nameInRow,
          image: AvatarRepository().avatarImage(user.userId),
          avatarSentiment: dashboard.myTile.sentiment,
          onSentimentIconTap: () {
            print('AvatarRow open SetMySentiment');

            Navigator.pushNamed(
              context,
              SetMySentimentPage.routeUri,
              arguments: BlocProvider.of<DashboardBloc>(context),
            );
          },
        ),
      );
    });
  }

  Widget _contactList(Dashboard dashboard, DateTime now) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Paragraph(
          child: Headline(
              'Wetter in meiner Fam-Group "${dashboard.groupData.groupName}"'),
        ),
        Expanded(
          child: Paragraph(
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
              image: AvatarRepository().avatarImage(tile.user.userId),
              avatarSentiment: tile.sentiment,
              lastStatusUpdate: tile.lastStatusUpdate,
              now: now,
            ),
          ),
        );
      },
    ).toList(growable: false);
  }

  Widget _widgetWithDashboardBloc(
      Widget Function(StateWithDashboard state) widgetFactory) {
    return BlocBuilder<DashboardBloc, DashboardState>(
      builder: (context, state) {
        if (state.hasDashboard) {
          return widgetFactory(state as StateWithDashboard);
        } else {
          return LoadingSpinner();
        }
      },
    );
  }
}
