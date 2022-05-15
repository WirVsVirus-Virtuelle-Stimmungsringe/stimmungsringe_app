import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';

typedef SvgPictureFactory = SvgPicture Function(double width, double height);

class AvatarSvg extends StatelessWidget {
  final SvgPictureFactory svgPictureFactory;
  final Color borderColor;
  final Color backgroundColor;
  final double size;

  const AvatarSvg({
    Key? key,
    required this.svgPictureFactory,
    this.borderColor = CupertinoColors.white,
    this.backgroundColor = const Color(0xff6e8983),
    this.size = 150,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const borderWidth = 4.0;
    final borderRadius = BorderRadius.circular(size / 2);

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: borderRadius,
        border: Border.all(
          color: borderColor,
          width: borderWidth,
        ),
      ),
      child: ClipRRect(
        borderRadius: borderRadius,
        child: svgPictureFactory(size - borderWidth, size - borderWidth),
      ),
    );
  }
}
