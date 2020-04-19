import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stimmungsringeapp/data/freezed_classes.dart';
import 'package:stimmungsringeapp/pages/dashboard/bloc/bloc.dart';
import 'package:stimmungsringeapp/pages/group_settings/group_settings_page.dart';
import 'package:stimmungsringeapp/pages/other_detail/other_detail_page.dart';
import 'package:stimmungsringeapp/pages/set_my_sentiment_page.dart';
import 'package:stimmungsringeapp/pages/user_settings/user_settings_page.dart';
import 'package:stimmungsringeapp/repositories/assets_repository.dart';
import 'package:stimmungsringeapp/repositories/dashboard_repository.dart';
import 'package:stimmungsringeapp/widgets/avatar_row.dart';
import 'package:stimmungsringeapp/widgets/avatar_row_condensed.dart';
import 'package:stimmungsringeapp/widgets/loading_spinner.dart';

class DashboardPage extends StatefulWidget {
  static const String routeUri = '/home';

  static MapEntry<String, WidgetBuilder> makeRoute(
      DashboardRepository dashboardRepository) {
    return MapEntry(
      routeUri,
      _makeRouteBuilder(dashboardRepository),
    );
  }

  static PageRouteBuilder<Widget> makeRouteWithoutTransition(
      DashboardRepository dashboardRepository) {
    return PageRouteBuilder<Widget>(
        pageBuilder: (context, animation1, animation2) =>
            _makeRouteBuilder(dashboardRepository)(context));
  }

  static WidgetBuilder _makeRouteBuilder(
      DashboardRepository dashboardRepository) {
    return (BuildContext c) => BlocProvider<DashboardBloc>(
          create: (context) =>
              DashboardBloc(dashboardRepository: dashboardRepository),
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
                child: _contactList(),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _avatarRow() {
    return BlocBuilder<DashboardBloc, DashboardState>(
      builder: (context, state) {
        if (state.hasDashboard) {
          final Dashboard dashboard = (state as StateWithDashboard).dashboard;
          final UserMinimal user = dashboard.myTile.user;
          return GestureDetector(
            onTap: () => Navigator.pushNamed(
              context,
              UserSettingsPage.routeUri,
            ),
            child: AvatarRow(
              name: user.displayName,
              image: AssetsRepository().avatarImage(user.userId),
              avatarSentiment: dashboard.myTile.sentiment,
              onSentimentIconTap: () => Navigator.pushNamed(
                context,
                SetMySentimentPage.routeUri,
                arguments: BlocProvider.of<DashboardBloc>(context),
              ),
            ),
          );
        } else {
          return LoadingSpinner();
        }
      },
    );
  }

  Widget _contactList() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Title(
          color: CupertinoColors.black,
          child: Text(
            'Meine Achtgeber:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: BlocBuilder<DashboardBloc, DashboardState>(
            builder: (context, state) {
              if (state.hasDashboard) {
                final Dashboard dashboard =
                    (state as StateWithDashboard).dashboard;
                return ListView(
                  padding: const EdgeInsets.only(top: 8),
                  children: _otherTiles(context, dashboard),
                );
              } else {
                return LoadingSpinner();
              }
            },
          ),
        )
      ],
    );
  }

  List<Widget> _otherTiles(BuildContext context, Dashboard dashboard) {
    return dashboard.otherTiles
        .map(
          (tile) => Container(
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
                name: tile.user.displayName,
                image: AssetsRepository().avatarImage(tile.user.userId),
                avatarSentiment: tile.sentiment,
              ),
            ),
          ),
        )
        .toList(growable: false);
  }
}
