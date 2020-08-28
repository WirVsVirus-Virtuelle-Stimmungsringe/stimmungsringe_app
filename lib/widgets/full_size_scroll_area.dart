import 'package:flutter/cupertino.dart';

class FullSizeScrollArea extends StatelessWidget {
  final Widget child;

  const FullSizeScrollArea({Key key, @required this.child})
      : assert(child != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext buildContext, BoxConstraints viewportConstraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints:
                BoxConstraints(minHeight: viewportConstraints.maxHeight),
            child: IntrinsicHeight(
              child: child,
            ),
          ),
        );
      },
    );
  }
}
