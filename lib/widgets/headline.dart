import 'package:flutter/cupertino.dart';

class Headline extends StatelessWidget {
  final String _text;

  const Headline(this._text, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      _text,
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      textAlign: TextAlign.center,
    );
  }
}
