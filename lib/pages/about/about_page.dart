import 'package:familiarise/widgets/paragraph.dart';
import 'package:flutter/cupertino.dart';

class AboutPage extends StatelessWidget {
  static const String routeUri = '/about';

  static MapEntry<String, WidgetBuilder> makeRoute() => MapEntry(
        routeUri,
        (_) => const AboutPage(),
      );

  const AboutPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Impressum'),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: SingleChildScrollView(
            child: Column(
              children: const <Widget>[
                Paragraph(
                  child: Text(
                    'Die familiarise-App wird bereitgestellt von '
                    'netten Leute, die Corona auch doof finden. '
                    'TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO',
                    textAlign: TextAlign.left,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
