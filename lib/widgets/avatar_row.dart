import 'package:familiarise/data/sentiment.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

const double _avatarSize = 150;

class AvatarRow extends StatelessWidget {
  final Sentiment avatarSentiment;
  final String name;
  final ImageProvider image;
  final void Function() onSentimentIconTap;
  final void Function() onInboxIconTap;
  final int inboxMessageCount;

  const AvatarRow({
    Key key,
    @required this.avatarSentiment,
    @required this.name,
    @required this.image,
    this.onSentimentIconTap,
    this.onInboxIconTap,
    this.inboxMessageCount,
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
                  Radius.circular(_avatarSize / 2),
                ),
                border: Border.all(
                  color: CupertinoColors.white,
                  width: 4.0,
                ),
              ),
            ),
          ),
          (inboxMessageCount != null)
              ? Positioned(
                  left: _avatarSize - 40,
                  bottom: _avatarSize - 70,
                  child: Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      wrapGestureDetector(
                        onTap: onInboxIconTap,
                        child: Container(
                          color: Color.fromRGBO(236, 56, 156, .3),
                          padding: const EdgeInsets.all(20.0),
                          child: Image.asset(
                            'assets/images/heart.png',
                            width: 50,
                            color: Color.fromRGBO(236, 56, 56, 1.0),
                          ),
                        ),
                      ),
                      Text(inboxMessageCount.toString(),
                          style: const TextStyle(
                            color: CupertinoColors.white,
                            fontSize: 20,
                          )),
                    ],
                  ),
                )
              : Container(),
          Positioned(
            bottom: 10,
            left: _avatarSize + 20 + 10,
            child: Text(
              name,
              style: const TextStyle(
                color: Color(0x7f000000),
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Widget wrapGestureDetector({Widget child, void Function() onTap}) =>
      (onTap != null)
          ? GestureDetector(
              onTap: () {
                onTap();
              },
              child: child,
            )
          : child;

  Widget _buildSentimentIcon() {
    final Widget sentimentIcon = FaIcon(
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
