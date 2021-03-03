import 'package:familiarise/pages/about/impressum_page.dart';
import 'package:familiarise/pages/onboarding/bloc/onboarding_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ImpressumLink {
  static Widget buildImpressumLink(BuildContext context) {
    return GestureDetector(
      child: Text(
        'Impressum',
        style:
            TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
      ),
      onTap: () {
        Navigator.pushNamed(
          context,
          ImpressumPage.routeUri,
          arguments: BlocProvider.of<OnboardingBloc>(context),
        );
      },
    );
  }
}
