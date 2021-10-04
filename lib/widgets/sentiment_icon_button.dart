import 'package:familiarise/data/sentiment.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SentimentIconButton extends StatelessWidget {
  final Sentiment sentiment;
  final bool isSelected;
  final void Function(Sentiment) onTap;

  const SentimentIconButton({
    Key? key,
    required this.sentiment,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap(sentiment);
      },
      child: FaIcon(
        sentiment.icon,
        size: 70,
        color: isSelected
            ? CupertinoColors.activeBlue
            : CupertinoColors.inactiveGray,
      ),
    );
  }
}
