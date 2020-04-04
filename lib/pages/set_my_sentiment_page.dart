import 'package:flutter/cupertino.dart';
import 'package:stimmungsringeapp/data/dashboard.dart';
import 'package:stimmungsringeapp/data/sentiment.dart';
import 'package:stimmungsringeapp/widgets/avatar_row.dart';
import 'package:stimmungsringeapp/widgets/sentiment_icon_button.dart';

import '../global_constants.dart';

class SetMySentimentPage extends StatelessWidget {
  final Dashboard dashboard;
  final void Function(Sentiment) onSentimentChange;

  SetMySentimentPage({
    Key key,
    @required this.dashboard,
    @required this.onSentimentChange,
  })  : assert(dashboard != null),
        assert(onSentimentChange != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> allSentiments = Sentiment.all.map((sentiment) {
      return Center(
        child: SentimentIconButton(
          sentiment: sentiment,
          isSelected: dashboard.sentiment == sentiment,
          onTap: onSentimentChange,
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
              name: dashboard.user.displayName,
              image: NetworkImage(avatarImageUrl(dashboard.user.userId)),
              avatarSentiment: dashboard.sentiment,
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
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
  }
}
