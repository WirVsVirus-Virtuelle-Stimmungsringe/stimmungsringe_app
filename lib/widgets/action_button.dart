import 'package:familiarise/widgets/button_group.dart';
import 'package:flutter/cupertino.dart';

class ActionButton extends StatelessWidget {
  final Text text;
  final VoidCallback? onPressed;

  const ActionButton({
    Key? key,
    required this.text,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ButtonGroup? buttonGroup =
        context.findAncestorWidgetOfExactType<ButtonGroup>();
    final BorderRadius? borderRadius =
        buttonGroup == null ? BorderRadius.circular(12.0) : null;

    return CupertinoButton(
      borderRadius: borderRadius,
      color: CupertinoColors.activeBlue,
      disabledColor: CupertinoColors.systemGrey4,
      onPressed: onPressed,
      child: text,
    );
  }
}
