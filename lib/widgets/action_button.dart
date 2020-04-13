import 'package:flutter/cupertino.dart';

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
    return CupertinoButton(
      borderRadius: BorderRadius.circular(12.0),
      color: CupertinoColors.activeBlue,
      onPressed: onPressed,
      child: text,
    );
  }
}
