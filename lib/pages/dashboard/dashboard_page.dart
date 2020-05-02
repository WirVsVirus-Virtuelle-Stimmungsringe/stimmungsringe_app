import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share/share.dart';
import 'package:stimmungsringeapp/data/dashboard.dart';
import 'package:stimmungsringeapp/pages/dashboard/bloc/bloc.dart';
import 'package:stimmungsringeapp/pages/group_settings/group_settings_page.dart';
import 'package:stimmungsringeapp/pages/other_detail/other_detail_page.dart';
import 'package:stimmungsringeapp/pages/set_my_sentiment_page.dart';
import 'package:stimmungsringeapp/pages/user_settings/bloc/bloc.dart';
import 'package:stimmungsringeapp/pages/user_settings/user_settings_page.dart';
import 'package:stimmungsringeapp/repositories/assets_repository.dart';
import 'package:stimmungsringeapp/repositories/dashboard_repository.dart';
import 'package:stimmungsringeapp/widgets/avatar_row.dart';
import 'package:stimmungsringeapp/widgets/avatar_row_condensed.dart';
import 'package:stimmungsringeapp/widgets/headline.dart';
import 'package:stimmungsringeapp/widgets/loading_spinner.dart';
import 'package:stimmungsringeapp/widgets/paragraph.dart';

class DashboardPage extends StatefulWidget {
  static const String routeUri = '/home';

  static MapEntry<String, WidgetBuilder> makeRoute(
      DashboardRepository dashboardRepository,
      UserSettingsBloc userSettingsBloc) {
    return MapEntry(
      routeUri,
      _makeRouteBuilder(dashboardRepository, userSettingsBloc),
    );
  }

  static PageRouteBuilder<Widget> makeRouteWithoutTransition(
      DashboardRepository dashboardRepository,
      UserSettingsBloc userSettingsBloc) {
    return PageRouteBuilder<Widget>(
        pageBuilder: (context, animation1, animation2) =>
            _makeRouteBuilder(dashboardRepository, userSettingsBloc)(context));
  }

  static WidgetBuilder _makeRouteBuilder(
      DashboardRepository dashboardRepository,
      UserSettingsBloc userSettingsBloc) {
    return (BuildContext c) => BlocProvider<DashboardBloc>(
          create: (context) => DashboardBloc(
            dashboardRepository: dashboardRepository,
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
                child: _widgetWithDashboardBloc((dashboard) {
                  if (dashboard.otherTiles.isEmpty) {
                    return _emptyGroupInfo(dashboard.groupData);
                  } else {
                    return _contactList(dashboard);
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
    return _widgetWithDashboardBloc((dashboard) {
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
          image: AssetsRepository().avatarImage(user.userId),
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

  Widget _contactList(Dashboard dashboard) {
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
              children: _otherTiles(context, dashboard),
            ),
          ),
        )
      ],
    );
  }

  List<Widget> _otherTiles(BuildContext context, Dashboard dashboard) {
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
              image: AssetsRepository().avatarImage(tile.user.userId),
              avatarSentiment: tile.sentiment,
            ),
          ),
        );
      },
    ).toList(growable: false);
  }

  Widget _widgetWithDashboardBloc(
      Widget Function(Dashboard dashboard) widgetFactory) {
    return BlocBuilder<DashboardBloc, DashboardState>(
      builder: (context, state) {
        if (state.hasDashboard) {
          final Dashboard dashboard = (state as StateWithDashboard).dashboard;
          return widgetFactory(dashboard);
        } else {
          return LoadingSpinner();
        }
      },
    );
  }
}
