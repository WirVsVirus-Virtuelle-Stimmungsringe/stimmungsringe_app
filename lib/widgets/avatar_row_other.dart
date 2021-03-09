import 'package:familiarise/data/sentiment.dart';
import 'package:familiarise/widgets/avatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

const double _avatarSize = 150;

class AvatarRowOther extends StatelessWidget {
  final Sentiment avatarSentiment;
  final String sentimentText;
  final String name;
  final ImageProvider image;

  const AvatarRowOther({
    Key key,
    @required this.avatarSentiment,
    @required this.sentimentText,
    @required this.name,
    @required this.image,
  })  : assert(avatarSentiment != null),
        assert(sentimentText != null),
        assert(name != null),
        assert(image != null),
        super(key: key);

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
                  avatarSentiment.colors.endColor,
                ],
              ),
            ),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Container(),
                ),
                Expanded(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        sentimentText,
                        style: const TextStyle(
                          color: CupertinoColors.white,
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          _buildAvatarImage(),
          _buildWeatherIndicator(),
          Positioned(
            bottom: 10,
            left: _avatarSize + 20 + 10,
            child: Text(
              name,
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// circular image
  Widget _buildAvatarImage() {
    return Positioned(
      top: 20,
      left: 20,
      child: Avatar(
        image: image,
        borderColor: CupertinoColors.white,
        backgroundColor: avatarSentiment.avatarIconBackgroundColor,
        size: _avatarSize,
      ),
    );
  }

  /// show heart symbol with message count
  Widget _buildWeatherIndicator() {
    const indicatorSize = 60.0;
    const indicatorBorderWidth = 2.0;

    return Positioned(
      left: _avatarSize - 20,
      bottom: _avatarSize - 60,
      width: indicatorSize,
      height: indicatorSize,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: CupertinoColors.white,
            width: indicatorBorderWidth,
          ),
          borderRadius: BorderRadius.circular(indicatorSize / 2),
        ),
        child: ClipOval(
          child: Container(
            color: const Color(0xff399ee6),
            child: Center(
              child: FaIcon(
                avatarSentiment.icon,
                size: indicatorSize * 0.7 - (indicatorBorderWidth * 2),
                color: CupertinoColors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
