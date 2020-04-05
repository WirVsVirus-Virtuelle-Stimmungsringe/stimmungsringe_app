import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stimmungsringeapp/data/freezed_classes.dart';
import 'package:stimmungsringeapp/data/sentiment.dart';
import 'package:stimmungsringeapp/global_constants.dart';
import 'package:stimmungsringeapp/pages/dashboard/bloc/bloc.dart';
import 'package:stimmungsringeapp/pages/other_detail_page.dart';
import 'package:stimmungsringeapp/pages/set_my_sentiment_page.dart';
import 'package:stimmungsringeapp/repositories/dashboard_repository.dart';
import 'package:stimmungsringeapp/widgets/avatar_row.dart';
import 'package:stimmungsringeapp/widgets/avatar_row_condensed.dart';
import 'package:stimmungsringeapp/widgets/loading_spinner_widget.dart';

class OverviewPage extends StatelessWidget {
  final DashboardRepository dashboardRepository;

  OverviewPage({Key key, DashboardRepository this.dashboardRepository})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Übersicht'),
        trailing: GestureDetector(
          onTap: () => {}, // TODO
          child: Icon(
            CupertinoIcons.add,
            color: CupertinoColors.activeBlue,
          ),
        ),
      ),
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            BlocBuilder<DashboardBloc, DashboardState>(
                builder: (context, state) {
              if (state.hasDashboard) {
                final Dashboard dashboard =
                    (state as StateWithDashboard).dashboard;
                final UserMinimal user =
                    (state as StateWithDashboard).dashboard.myTile.user;
                final SentimentStatus sentimentStatus =
                    (state as StateWithDashboard)
                        .dashboard
                        .myTile
                        .sentimentStatus;
                return AvatarRow(
                  name: user.displayName,
                  image: NetworkImage(avatarImageUrl(user.userId)),
                  avatarSentiment:
                      SentimentUi.fromSentimentStatus(sentimentStatus),
                  onSentimentIconTap: () =>
                      Navigator.of(context).push(CupertinoPageRoute(
                          builder: (_) => BlocProvider.value(
                                value: BlocProvider.of<DashboardBloc>(context),
                                child: new SetMySentimentPage(
                                    dashboardRepository: dashboardRepository),
                              ))),
                );
              } else {
                return LoadingSpinnerWidget();
              }
            }),
            Container(
              margin: EdgeInsets.symmetric(vertical: 8),
              child: Title(
                color: CupertinoColors.black,
                child: Text(
                  'Meine Achtgeber:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Expanded(
              child: BlocBuilder<DashboardBloc, DashboardState>(
                  builder: (context, state) {
                if (state.hasDashboard) {
                  final Dashboard dashboard =
                      (state as StateWithDashboard).dashboard;
                  return ListView(
                    padding: const EdgeInsets.all(8),
                    children: otherTiles(context, dashboard),
                  );
                } else {
                  return LoadingSpinnerWidget();
                }
              }),
            )
          ],
        ),
      ),
    );
  }

  List<Widget> otherTiles(BuildContext context, Dashboard dashboard) {
    return dashboard.otherTiles
        .map(
          (tile) => Container(
              padding: EdgeInsets.symmetric(vertical: 4),
              child: GestureDetector(
                child: AvatarRowCondensed(
                  name: tile.user.displayName,
                  image: NetworkImage(avatarImageUrl(tile.user.userId)),
                  avatarSentiment:
                      SentimentUi.fromSentimentStatus(tile.sentimentStatus),
                ),
                onTap: () => Navigator.of(context).push(CupertinoPageRoute(
                    builder: (_) => BlocProvider.value(
                          value: BlocProvider.of<DashboardBloc>(context),
                          child: new OtherDetailPage(
                              dashboardRepository: dashboardRepository,
                              otherUserId: tile.user.userId),
                        ))),
              )),
        )
        .toList(growable: false);
  }
}
