import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/fa_icon.dart';
import 'package:stimmungsringeapp/data/sentiment.dart';

class SentimentIconButton extends StatelessWidget {
  final Sentiment sentiment;
  final bool isSelected;
  final void Function(Sentiment) onTap;

  SentimentIconButton({
    Key key,
    @required this.sentiment,
    @required this.isSelected,
    @required this.onTap,
  })  : assert(sentiment != null),
        assert(isSelected != null),
        assert(onTap != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          onTap(this.sentiment);
        },
        child: FaIcon(
          sentiment.icon,
          size: 70,
          color: isSelected
              ? CupertinoColors.activeBlue
              : CupertinoColors.inactiveGray,
        ),
      ),
    );
  }
}
