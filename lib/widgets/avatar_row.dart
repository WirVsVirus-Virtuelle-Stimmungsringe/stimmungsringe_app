import 'package:familiarise/data/sentiment.dart';
import 'package:familiarise/widgets/avatar_widget_factory.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

const double _avatarSize = 150;

class AvatarRow extends StatelessWidget {
  final Sentiment avatarSentiment;
  final String name;
  final AvatarWidgetFactory avatarWidgetFactory;
  final void Function()? onAvatarImageTap;
  final void Function()? onSentimentIconTap;
  final void Function()? onInboxIconTap;
  final int? inboxMessageCount;

  const AvatarRow({
    Key? key,
    required this.avatarSentiment,
    required this.name,
    required this.avatarWidgetFactory,
    this.onAvatarImageTap,
    this.onSentimentIconTap,
    this.onInboxIconTap,
    this.inboxMessageCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
          buildAvatarImage(),
          buildInboxIndicator(),
          Positioned(
            bottom: 10,
            left: _avatarSize + 20 + 10,
            child: wrapGestureDetector(
              onTap: onAvatarImageTap,
              child: Text(
                name,
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// circular image
  Widget buildAvatarImage() {
    return Positioned(
      top: 20,
      left: 20,
      child: wrapGestureDetector(
        onTap: onAvatarImageTap,
        child: avatarWidgetFactory(
          backgroundColor: avatarSentiment.avatarIconBackgroundColor,
          // ignore: avoid_redundant_argument_values
          size: _avatarSize,
        ),
      ),
    );
  }

  /// show heart symbol with message count
  Widget buildInboxIndicator() {
    if (inboxMessageCount == null) {
      return Container();
    }
    return Positioned(
      left: _avatarSize - 40,
      bottom: _avatarSize - 70,
      child: wrapGestureDetector(
        onTap: onInboxIconTap,
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20.0),
              child: const FaIcon(
                FontAwesomeIcons.solidHeart,
                size: 50,
                color: Color.fromRGBO(236, 56, 56, 1.0),
              ),
            ),
            Text(
              inboxMessageCount.toString(),
              style: const TextStyle(
                color: CupertinoColors.white,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }

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
                const FaIcon(
                  FontAwesomeIcons.pen,
                  color: CupertinoColors.white,
                  size: _avatarSize / 7,
                ),
              ],
            ),
          )
        : Center(
            child: sentimentIcon,
          );
  }

  static Widget wrapGestureDetector({
    required Widget child,
    void Function()? onTap,
  }) =>
      (onTap != null)
          ? GestureDetector(
              onTap: () {
                onTap();
              },
              child: child,
            )
          : child;
}
