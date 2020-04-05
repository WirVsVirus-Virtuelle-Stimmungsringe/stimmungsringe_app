import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stimmungsringeapp/data/sentiment.dart';

const double _avatarSize = 90;
const double _sentimentIconSize = 70;

class AvatarRowCondensed extends StatelessWidget {
  final Sentiment avatarSentiment;
  final String name;
  final ImageProvider image;

  const AvatarRowCondensed({
    Key key,
    @required this.avatarSentiment,
    @required this.name,
    @required this.image,
  })  : assert(avatarSentiment != null),
        assert(name != null),
        assert(image != null),
        super(key: key);

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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: _avatarSize,
                height: _avatarSize,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: image,
                    fit: BoxFit.cover,
                  ),
                  borderRadius: const BorderRadius.all(
                    const Radius.circular(_avatarSize / 2),
                  ),
                  border: Border.all(
                    color: CupertinoColors.white,
                    width: 4.0,
                  ),
                ),
              ),
              Text(
                name,
                style: const TextStyle(
                  color: CupertinoColors.white,
                  fontSize: 20,
                ),
                softWrap: true,
              ),
            ],
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(right: 20),
                  child: FaIcon(
                    avatarSentiment.icon,
                    size: _sentimentIconSize,
                    color: CupertinoColors.white,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
