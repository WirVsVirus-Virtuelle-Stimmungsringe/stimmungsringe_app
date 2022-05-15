import 'package:familiarise/data/sentiment.dart';
import 'package:familiarise/widgets/avatar_widget_factory.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

const _avatarSize = 150.0;
const _avatarBorderWidth = 4.0;
const _indicatorSize = 60.0;
const _indicatorBorderWidth = 3.0;

class AvatarRowOther extends StatelessWidget {
  final Sentiment avatarSentiment;
  final String sentimentText;
  final String name;
  final AvatarWidgetFactory avatarWidgetFactory;

  const AvatarRowOther({
    Key? key,
    required this.avatarSentiment,
    required this.sentimentText,
    required this.name,
    required this.avatarWidgetFactory,
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
                  avatarSentiment.colors.endColor,
                ],
              ),
            ),
            child: Row(
              children: <Widget>[
                const SizedBox(
                  width: _avatarSize +
                      _avatarBorderWidth * 2 +
                      _indicatorSize / 2 +
                      _indicatorBorderWidth * 2,
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
      child: avatarWidgetFactory(
        backgroundColor: avatarSentiment.avatarIconBackgroundColor,
        // ignore: avoid_redundant_argument_values
        size: _avatarSize,
      ),
    );
  }

  /// show heart symbol with message count
  Widget _buildWeatherIndicator() {
    return Positioned(
      left: _avatarSize - 20,
      bottom: _avatarSize - 60,
      width: _indicatorSize,
      height: _indicatorSize,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: CupertinoColors.white,
            width: _indicatorBorderWidth,
          ),
          borderRadius: BorderRadius.circular(_indicatorSize / 2),
        ),
        child: ClipOval(
          child: Container(
            color: const Color(0xff399ee6),
            child: Center(
              child: FaIcon(
                avatarSentiment.icon,
                size: _indicatorSize * 0.7 - (_indicatorBorderWidth * 2),
                color: CupertinoColors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
