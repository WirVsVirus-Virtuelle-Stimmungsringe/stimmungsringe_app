import 'package:flutter/cupertino.dart';

const double _avatarSize = 150;

class Avatar extends StatelessWidget {
  final ImageProvider image;
  final Color borderColor;
  final Color backgroundColor;
  final double size;

  const Avatar({
    Key key,
    @required this.image,
    this.borderColor,
    this.backgroundColor,
    this.size,
  })  : assert(image != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = this.size ?? _avatarSize;

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: backgroundColor ?? const Color(0xff6e8983),
        image: DecorationImage(
          image: image,
          fit: BoxFit.contain,
        ),
        borderRadius: BorderRadius.circular(size / 2),
        border: Border.all(
          color: borderColor ?? CupertinoColors.white,
          width: 4.0,
        ),
      ),
    );
  }
}
