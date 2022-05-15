import 'package:familiarise/data/sentiment.dart';
import 'package:familiarise/utils/calc_time_difference_in_words.dart';
import 'package:familiarise/widgets/avatar_widget_factory.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

const double _avatarSize = 90;
const double _sentimentIconSize = 70;

class AvatarRowCondensed extends StatelessWidget {
  final Sentiment avatarSentiment;
  final String name;
  final AvatarWidgetFactory avatarWidgetFactory;
  final DateTime lastStatusUpdate;
  final DateTime now;

  const AvatarRowCondensed({
    Key? key,
    required this.avatarSentiment,
    required this.name,
    required this.avatarWidgetFactory,
    required this.lastStatusUpdate,
    required this.now,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            avatarSentiment.colors.startColor,
            avatarSentiment.colors.endColor
          ],
        ),
      ),
      padding: const EdgeInsets.all(10),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: avatarWidgetFactory(
                backgroundColor: avatarSentiment.avatarIconBackgroundColor,
                size: _avatarSize,
              ),
            ),
            Expanded(
              child: Text(
                name,
                style: const TextStyle(
                  color: CupertinoColors.white,
                  fontSize: 20,
                ),
                softWrap: true,
              ),
            ),
            Column(
              children: <Widget>[
                Center(
                  child: FaIcon(
                    avatarSentiment.icon,
                    size: _sentimentIconSize,
                    color: CupertinoColors.white,
                  ),
                ),
                Center(
                  child: Text(
                    calcTimeDifferenceInWords(lastStatusUpdate, now),
                    style: const TextStyle(
                      color: CupertinoColors.white,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
