import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stimmungsringeapp/data/freezed_classes.dart';
import 'package:stimmungsringeapp/data/sentiment.dart';
import 'package:stimmungsringeapp/pages/dashboard/bloc/bloc.dart';
import 'package:stimmungsringeapp/widgets/avatar_row.dart';
import 'package:stimmungsringeapp/widgets/loading_spinner_widget.dart';
import 'package:stimmungsringeapp/widgets/sentiment_icon_button.dart';

import '../global_constants.dart';

class SetMySentimentPage extends StatelessWidget {
  //final Dashboard dashboard;
  //final void Function(SentimentUi) onSentimentChange;

  SetMySentimentPage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DashboardBloc dashboardBloc = BlocProvider.of<DashboardBloc>(context);

    return BlocBuilder<DashboardBloc, DashboardState>(
        builder: (context, state) {
      if (state.hasDashboard) {
        final Dashboard dashboard = (state as StateWithDashboard).dashboard;

        List<Widget> allSentiments = SentimentUi.all.map((sentiment) {
          return Center(
            child: SentimentIconButton(
              sentiment: sentiment,
              isSelected:
                  dashboard.myTile.sentimentStatus.sentiment.sentimentCode ==
                      sentiment.name,
              onTap: (sentimentUi) {
                dashboardBloc.add(SetNewSentiment(sentiment));
              },
            ),
          );
        }).toList(growable: false);

        return CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
            middle: Text('Persönliches Wetter'),
          ),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                AvatarRow(
                  name: dashboard.myTile.user.displayName,
                  image: NetworkImage(
                      avatarImageUrl(dashboard.myTile.user.userId)),
                  avatarSentiment: SentimentUi.fromSentimentStatus(
                      dashboard.myTile.sentimentStatus),
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  child: Title(
                    color: CupertinoColors.black,
                    child: Text(
                      'Wie würdest Du Dein persönliches Wetter gerade beschreiben?',
                    ),
                  ),
                ),
                Expanded(
                  child: GridView.count(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 3,
                    children: allSentiments,
                  ),
                )
              ],
            ),
          ),
        );
      } else {
        return LoadingSpinnerWidget();
      }
    });
  }
}
