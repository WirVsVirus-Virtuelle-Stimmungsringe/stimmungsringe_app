import 'package:flutter/cupertino.dart';

class FamiliariseLogo extends StatelessWidget {
  const FamiliariseLogo({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      child: Image.asset('assets/images/familiarise_logo_large.png'),
    );
  }
}
