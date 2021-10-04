import 'package:flutter/cupertino.dart';

class WaitDialog extends StatelessWidget {
  const WaitDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double activityIndicatorRadius = 15;
    const double activityIndicatorSize = activityIndicatorRadius * 2;

    return Center(
      child: SizedBox(
        width: 270,
        child: CupertinoPopupSurface(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                CupertinoActivityIndicator(
                  radius: activityIndicatorRadius,
                ),
                Expanded(
                  child: Text(
                    'Bitte warten...',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  width: activityIndicatorSize,
                  height: activityIndicatorSize,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
