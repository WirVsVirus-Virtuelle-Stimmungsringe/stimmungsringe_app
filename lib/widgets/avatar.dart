import 'package:flutter/cupertino.dart';

const double _avatarSize = 150;

class Avatar extends StatelessWidget {
  final ImageProvider image;
  final Color borderColor;
  final double size;

  const Avatar({Key key, @required this.image, this.borderColor, this.size})
      : assert(image != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = this.size ?? _avatarSize;

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: const Color.fromRGBO(110, 137, 131, 1.0),
        image: DecorationImage(
          image: image,
          fit: BoxFit.contain,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(size / 2),
        ),
        border: Border.all(
          color: borderColor ?? CupertinoColors.white,
          width: 4.0,
        ),
      ),
    );
  }
}
