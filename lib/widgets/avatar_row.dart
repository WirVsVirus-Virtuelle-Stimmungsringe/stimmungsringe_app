import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stimmungsringeapp/data/sentiment.dart';

const double _avatarSize = 150;

class AvatarRow extends StatelessWidget {
  final Sentiment avatarSentiment;
  final String name;
  final ImageProvider image;
  final void Function() onSentimentIconTap;

  const AvatarRow({
    Key key,
    @required this.avatarSentiment,
    @required this.name,
    @required this.image,
    this.onSentimentIconTap,
  })  : assert(avatarSentiment != null),
        assert(name != null),
        assert(image != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _avatarSize + 20,
      child: Stack(
        children: <Widget>[
          Container(
            height: _avatarSize - (_avatarSize / 7),
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
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Container(),
                ),
                Expanded(
                  child: _buildSentimentIcon(),
                ),
              ],
            ),
          ),
          Positioned(
            top: 20,
            left: 20,
            child: Container(
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
          ),
          Positioned(
            bottom: 10,
            left: _avatarSize + 20 + 10,
            child: Text(
              name,
              style: TextStyle(
                color: const Color(0x7f000000),
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSentimentIcon() {
    Widget sentimentIcon = FaIcon(
      avatarSentiment.icon,
      size: _avatarSize / 2,
      color: CupertinoColors.white,
    );

    return onSentimentIconTap != null
        ? GestureDetector(
            onTap: onSentimentIconTap,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                sentimentIcon,
                Icon(
                  CupertinoIcons.pen,
                  color: CupertinoColors.white,
                ),
              ],
            ),
          )
        : Center(
            child: sentimentIcon,
          );
  }
}
