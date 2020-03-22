import 'package:flutter/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stimmungsringeapp/data/mood.dart';

const double _avatarSize = 150;

class AvatarRow extends StatelessWidget {
  final Mood avatarMood;
  final String name;
  final ImageProvider image;

  const AvatarRow({
    Key key,
    @required this.avatarMood,
    @required this.name,
    @required this.image,
  })  : assert(avatarMood != null),
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
                  avatarMood.colors.startColor,
                  avatarMood.colors.endColor
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
                  child: Center(
                    child: FaIcon(
                      avatarMood.icon,
                      size: _avatarSize / 2,
                      color: CupertinoColors.white,
                    ),
                  ),
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
}
