import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stimmungsringeapp/data/sentiment.dart';
import 'package:stimmungsringeapp/widgets/avatar_row.dart';

class SetMySentimentPage extends StatelessWidget {
  SetMySentimentPage({
    Key key,
    // TODO: add own data
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> allSentiments = Sentiment.all.map((sentiment) {
      return Center(
        child: FaIcon(
          sentiment.icon,
          size: 70,
          color: CupertinoColors.inactiveGray,
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
              name: 'Avatar',
              image: NetworkImage(
                  'https://2.bp.blogspot.com/-5lSguULPXW4/Tttrmykan6I/AAAAAAAAB_M/AlKHJLOKKO4/s1600/famosos_avatar.jpg'),
              avatarSentiment: Sentiment.thundery,
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              child: Title(
                color: CupertinoColors.black,
                child: Text(
                  'Wie würdest Du Dein persönliches Wetter gerade beschreiben?',
                ),
              ),
            ),
            Expanded(
              child: GridView.count(
                padding: EdgeInsets.symmetric(horizontal: 8),
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
