import 'package:familiarise/pages/dashboard/bloc/dashboard_bloc.dart';
import 'package:familiarise/pages/dashboard/bloc/dashboard_state.dart';
import 'package:familiarise/widgets/loading_spinner.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InboxPage extends StatefulWidget {
  static const String routeUri = '/inbox';

  static MapEntry<String, WidgetBuilder> makeRoute() =>
      MapEntry(routeUri, (BuildContext context) {
        final args =
            ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
        final DashboardBloc dashboardBloc =
            args['dashboardBloc'] as DashboardBloc;

        return BlocProvider.value(value: dashboardBloc, child: InboxPage());
      });

  @override
  _InboxPageState createState() => _InboxPageState();
}

class _InboxPageState extends State<InboxPage> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(middle: Text('Inbox')),
        child: SafeArea(child: BlocBuilder<DashboardBloc, DashboardState>(
          builder: (context, state) {
            if (state.hasDashboard) {
              return widgetFactory(state as StateWithDashboard);
            } else {
              return LoadingSpinner();
            }
          },
        )));
  }

  Widget widgetFactory(StateWithDashboard state) {
    final messageCount = state.inbox.messages.length;
    return Text("meine Message Inbox count=" + state.inbox.messages.length.toString());
  }
}
