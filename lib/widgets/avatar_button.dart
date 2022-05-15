import 'package:familiarise/widgets/avatar_widget_factory.dart';
import 'package:flutter/cupertino.dart';

class AvatarButton extends StatelessWidget {
  final AvatarWidgetFactory avatarWidgetFactory;
  final bool selected;
  final void Function() onAvatarTap;

  const AvatarButton({
    Key? key,
    required this.avatarWidgetFactory,
    required this.selected,
    required this.onAvatarTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final borderColor = selected
        ? const Color.fromRGBO(13, 120, 228, 1)
        : const Color.fromRGBO(0, 0, 0, 0);

    return GestureDetector(
      onTap: onAvatarTap,
      child: avatarWidgetFactory(borderColor: borderColor),
    );
  }
}
