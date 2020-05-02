import 'package:flutter/cupertino.dart';
import 'package:stimmungsringeapp/pages/dashboard/dashboard_page.dart';

class RoutingErrorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: SafeArea(
        child: Center(
          child: Column(
            children: <Widget>[
              const Text('Routing Error'),
              CupertinoButton(
                onPressed: () => Navigator.pushNamedAndRemoveUntil(
                  context,
                  DashboardPage.routeUri,
                  (_) => false,
                  arguments: null,
                ),
                child: const Text('zur Hauptseite'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
