import 'package:flutter/cupertino.dart';
import 'package:stimmungsringeapp/widgets/button_group.dart';

class ActionButton extends StatelessWidget {
  final Text text;
  final VoidCallback onPressed;

  const ActionButton({
    Key key,
    @required this.text,
    @required this.onPressed,
  })  : assert(text != null),
        assert(onPressed != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final ButtonGroup buttonGroup =
        context.findAncestorWidgetOfExactType<ButtonGroup>();
    final BorderRadius borderRadius =
        buttonGroup == null ? BorderRadius.circular(12.0) : null;

    return CupertinoButton(
      borderRadius: borderRadius,
      color: CupertinoColors.activeBlue,
      onPressed: onPressed,
      child: text,
    );
  }
}
