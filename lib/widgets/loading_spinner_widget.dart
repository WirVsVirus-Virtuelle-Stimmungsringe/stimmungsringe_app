import 'package:flutter/cupertino.dart';

class LoadingSpinnerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CupertinoActivityIndicator(
        animating: true,
      ),
    );
  }
}
