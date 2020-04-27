import 'package:flutter/cupertino.dart';

class Headline extends StatelessWidget {
  final String _text;

  const Headline(this._text, {Key key})
      : assert(_text != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      _text,
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      textAlign: TextAlign.center,
    );
  }
}
