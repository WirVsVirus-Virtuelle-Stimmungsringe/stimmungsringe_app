import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RetryView extends StatelessWidget {
  final VoidCallback onPressed;

  const RetryView({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.all(24.0),
            child: Text(
              'Oops. Die Verbindung ist scheinbar unterbrochen!',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          CupertinoButton(
            onPressed: onPressed,
            borderRadius: BorderRadius.circular(12.0),
            color: CupertinoColors.systemGrey3,
            child: const Text(
              "Nochmal versuchen",
              style: TextStyle(
                color: CupertinoColors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
