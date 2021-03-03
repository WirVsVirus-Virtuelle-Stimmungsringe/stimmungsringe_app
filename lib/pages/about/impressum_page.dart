import 'package:familiarise/pages/onboarding/bloc/onboarding_bloc.dart';
import 'package:familiarise/widgets/headline.dart';
import 'package:familiarise/widgets/paragraph.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ImpressumPage extends StatelessWidget {
  static const String routeUri = '/impressum';

  static MapEntry<String, WidgetBuilder> makeRoute() => MapEntry(
        routeUri,
        (_) => BlocProvider<OnboardingBloc>(
          create: (_) => OnboardingBloc(),
          child: ImpressumPage(),
        ),
      );

  const ImpressumPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                const Paragraph(
                  child: Headline('Impressum'),
                ),
                const Paragraph(
                  child: Text(
                    'Die familiarise-App wird bereitgestellt von '
                    'netten Leute, die Corona auch doof finden.'
                    'TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO',
                    textAlign: TextAlign.center,
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
