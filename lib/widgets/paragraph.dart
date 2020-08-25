import 'package:flutter/cupertino.dart';

class Paragraph extends StatelessWidget {
  final Widget child;
  final bool isFirstWidget;

  const Paragraph({
    Key key,
    @required this.child,
    this.isFirstWidget,
  })  : assert(child != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final edgeInsets =
        EdgeInsets.only(top: isFirstWidget ?? false ? 16 : 8, bottom: 8);
    return Padding(
      padding: edgeInsets,
      child: child,
    );
  }
}
