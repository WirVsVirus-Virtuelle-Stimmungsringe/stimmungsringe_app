import 'package:flutter/cupertino.dart';

class ButtonGroup extends StatelessWidget {
  final List<Widget> children;

  const ButtonGroup({Key key, @required this.children})
      : assert(children != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: children,
      ),
    );
  }
}
