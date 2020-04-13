import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stimmungsringeapp/data/freezed_classes.dart';
import 'package:stimmungsringeapp/global_constants.dart';
import 'package:stimmungsringeapp/pages/dashboard/bloc/bloc.dart';
import 'package:stimmungsringeapp/repositories/dashboard_repository.dart';
import 'package:stimmungsringeapp/widgets/avatar_row.dart';
import 'package:stimmungsringeapp/widgets/avatar_row_condensed.dart';
import 'package:stimmungsringeapp/widgets/loading_spinner_widget.dart';

class DashboardPage extends StatefulWidget {
  static const String routeUri = '/home';

  static MapEntry<String, WidgetBuilder> makeRoute(
          DashboardRepository dashboardRepository) =>
      MapEntry(
        routeUri,
        (BuildContext c) => BlocProvider<DashboardBloc>(
          create: (context) =>
              DashboardBloc(dashboardRepository: dashboardRepository),
          child: DashboardPage(),
        ),
      );

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
            "/group-settings",
            arguments: BlocProvider.of<DashboardBloc>(context),
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
          return AvatarRow(
            name: user.displayName,
            image: NetworkImage(avatarImageUrl(user.userId)),
            avatarSentiment: dashboard.myTile.sentiment,
            onSentimentIconTap: () => Navigator.pushNamed(
              context,
              "/my-sentiment",
              arguments: BlocProvider.of<DashboardBloc>(context),
            ),
          );
        } else {
          return LoadingSpinnerWidget();
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
                return LoadingSpinnerWidget();
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
                "/other-detail-page",
                arguments: {
                  'dashboardBloc': BlocProvider.of<DashboardBloc>(context),
                  'otherUserId': tile.user.userId,
                },
              ),
              child: AvatarRowCondensed(
                name: tile.user.displayName,
                image: NetworkImage(avatarImageUrl(tile.user.userId)),
                avatarSentiment: tile.sentiment,
              ),
            ),
          ),
        )
        .toList(growable: false);
  }
}
