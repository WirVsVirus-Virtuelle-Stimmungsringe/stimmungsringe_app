import 'package:flutter/cupertino.dart';

Widget largeLogo() {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
    child: Image.asset('assets/images/familiarise_logo_large.png'),
  );
}

CupertinoButton buildBigBlueButton({
  final Text text,
  Function() onPressed,
}) {
  return CupertinoButton(
    borderRadius: BorderRadius.circular(12.0),
    color: Color.fromRGBO(0, 117, 231, 0.95),
    onPressed: onPressed,
    child: text,
  );
}
