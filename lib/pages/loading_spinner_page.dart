import 'package:flutter/cupertino.dart';

class LoadingSpinnerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: SafeArea(
        child: Center(
          child: CupertinoActivityIndicator(
            animating: true,
          ),
        ),
      ),
    );
  }
}
