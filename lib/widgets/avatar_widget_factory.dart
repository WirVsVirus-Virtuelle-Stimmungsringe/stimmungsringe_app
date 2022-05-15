import 'package:familiarise/widgets/avatar.dart';
import 'package:familiarise/widgets/avatar_svg.dart';
import 'package:familiarise/widgets/protected_network_image.dart';
import 'package:flutter/cupertino.dart';

typedef AvatarWidgetFactory = Widget Function({
  Color borderColor,
  Color backgroundColor,
  double size,
});

AvatarWidgetFactory makeAvatarWidgetFactory({
  required String userId,
  required String avatarUrl,
  String? avatarSvgUrl,
}) {
  return ({
    Color borderColor = CupertinoColors.white,
    Color backgroundColor = const Color(0xff6e8983),
    double size = 150,
  }) =>
      avatarSvgUrl != null
          ? AvatarSvg(
              svgPictureFactory:
                  makeProtectedNetworkSvgPictureFactory(userId, avatarSvgUrl),
              borderColor: borderColor,
              backgroundColor: backgroundColor,
              size: size,
            )
          : Avatar(
              image: makeProtectedNetworkImage(userId, avatarUrl),
              borderColor: borderColor,
              backgroundColor: backgroundColor,
              size: size,
            );
}

AvatarWidgetFactory makeAvatarSvgWidgetFactory({
  required String userId,
  required String avatarSvgUrl,
}) {
  return ({
    Color borderColor = CupertinoColors.white,
    Color backgroundColor = const Color(0xff6e8983),
    double size = 150,
  }) =>
      AvatarSvg(
        svgPictureFactory:
            makeProtectedNetworkSvgPictureFactory(userId, avatarSvgUrl),
        borderColor: borderColor,
        backgroundColor: backgroundColor,
        size: size,
      );
}
