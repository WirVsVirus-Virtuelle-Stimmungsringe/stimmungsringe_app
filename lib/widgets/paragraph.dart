import 'package:flutter/cupertino.dart';

class Paragraph extends StatelessWidget {
  final Widget child;
  final bool isFirstWidget;
  final bool isLastWidget;

  const Paragraph({
    Key? key,
    required this.child,
    this.isFirstWidget = false,
    this.isLastWidget = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final edgeInsets = EdgeInsets.only(
      top: isFirstWidget ? 16 : 8,
      bottom: isLastWidget ? 0 : 8,
    );
    return Padding(
      padding: edgeInsets,
      child: child,
    );
  }
}
