import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PushMessageIcon extends StatelessWidget {
  final double size;

  const PushMessageIcon({this.size = 40, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: size,
      height: size,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color.fromRGBO(213, 0, 163, 1),
            Color.fromRGBO(235, 102, 0, 1)
          ],
        ),
      ),
      child: FaIcon(
        FontAwesomeIcons.solidHeart,
        size: 4 / 10 * size,
        color: CupertinoColors.white,
      ),
    );
  }
}
