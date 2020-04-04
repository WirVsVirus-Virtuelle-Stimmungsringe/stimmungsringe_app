import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stimmungsringeapp/data/dashboard.dart';
import 'package:stimmungsringeapp/data/sentiment.dart';
import 'package:stimmungsringeapp/global_constants.dart';
import 'package:stimmungsringeapp/pages/dashboard/bloc/bloc.dart';
import 'package:stimmungsringeapp/widgets/avatar_row.dart';
import 'package:stimmungsringeapp/widgets/avatar_row_condensed.dart';
import 'package:stimmungsringeapp/widgets/loading_spinner_widget.dart';

class OverviewPage extends StatelessWidget {
  OverviewPage({Key key}) : super(key: key);

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
                return AvatarRow(
                  name: dashboard.user.displayName,
                  image: NetworkImage(avatarImageUrl(dashboard.user.userId)),
                  avatarSentiment: dashboard.sentiment,
                  onSentimentIconTap: () =>
                      Navigator.pushNamed(context, 'my-sentiment'),
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
                      Sentiment.fromSentimentStatus(tile.sentimentStatus),
                ),
                onTap: () => Navigator.pushNamed(context, 'other-detail-page',
                    arguments: tile.user.userId),
              )),
        )
        .toList(growable: false);
  }
}
