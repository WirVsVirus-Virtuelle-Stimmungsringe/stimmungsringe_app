import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stimmungsringeapp/data/mood.dart';
import 'package:stimmungsringeapp/widgets/avatar_row.dart';
import 'package:stimmungsringeapp/widgets/avatar_row_condensed.dart';
import 'package:stimmungsringeapp/data/dashboard.dart';

class OverviewPage extends StatelessWidget {
  final Dashboard dashboard;

  OverviewPage({Key key,
    @required this.dashboard
      // TODO: add contacts data, add own data
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Übersicht'),
        trailing: GestureDetector(
          onTap: () => Navigator.pushNamed(context, 'own-mood'), // TODO
          child: Icon(
            CupertinoIcons.add,
            color: CupertinoColors.activeBlue,
          ),
        ),
      ),
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: dashboard == null ? [] : children(),
        ),
      ),
    );
  }

  List<Widget> children() {
    return <Widget>[
          AvatarRow(
            name: dashboard.myTile.user.displayName,
            image: NetworkImage(
                'https://2.bp.blogspot.com/-5lSguULPXW4/Tttrmykan6I/AAAAAAAAB_M/AlKHJLOKKO4/s1600/famosos_avatar.jpg'),
            avatarMood: Mood.thundery,
          ),
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
              child: ListView(
            padding: const EdgeInsets.all(8),
            children: otherTiles(),
          ))
        ];
  }

  List<Widget> otherTiles() {
    List<Widget> tiles = [];

    return dashboard.otherTiles.map((tile) =>
      Container(
        padding: EdgeInsets.symmetric(vertical: 4),
        child: AvatarRowCondensed(
          name: tile.user.displayName,
          image: NetworkImage(
              'https://2.bp.blogspot.com/-5lSguULPXW4/Tttrmykan6I/AAAAAAAAB_M/AlKHJLOKKO4/s1600/famosos_avatar.jpg'),
          avatarMood: Mood.sunny,
        ),
      )
    ).toList(growable: false);

  }
}
