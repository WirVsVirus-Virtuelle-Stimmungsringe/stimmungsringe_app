import 'package:flutter/cupertino.dart';

class Avatar extends StatelessWidget {
  final ImageProvider image;
  final Color borderColor;
  final Color backgroundColor;
  final double size;

  const Avatar({
    Key key,
    @required this.image,
    this.borderColor = CupertinoColors.white,
    this.backgroundColor = const Color(0xff6e8983),
    this.size = 150,
  })  : assert(image != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: backgroundColor,
        image: DecorationImage(
          image: image,
          fit: BoxFit.contain,
        ),
        borderRadius: BorderRadius.circular(size / 2),
        border: Border.all(
          color: borderColor,
          width: 4.0,
        ),
      ),
    );
  }
}
