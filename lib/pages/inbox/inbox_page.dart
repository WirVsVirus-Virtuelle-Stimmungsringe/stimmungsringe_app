import 'package:built_collection/src/list.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:familiarise/data/message.dart';
import 'package:familiarise/pages/dashboard/bloc/dashboard_bloc.dart';
import 'package:familiarise/pages/dashboard/bloc/dashboard_state.dart';
import 'package:familiarise/widgets/loading_spinner.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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
  int _current = 0;

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
      )),
    );
  }

  Widget widgetFactory(StateWithDashboard state) {
    final messageCount = state.inbox.messages.length;
    // return Text("meine Message Inbox count=" + state.inbox.messages.length.toString());

    return Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                CarouselSlider(
                  items: state.inbox.messages.map((message) {
                    return Text("text: " + message.text);
                  }).toList(growable: false),
                  options: CarouselOptions(
                      //height: height,
                      //autoPlay: true,
                      //enlargeCenterPage: true,
                      //viewportFraction: 1.0,
                      onPageChanged: (index, reason) {
                    setState(() {
                      _current = index;
                    });
                  }),
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: renderDots(state.inbox.messages)),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget buildMessageWidget(Message message) {
    return Text("message");
  }

  List<Widget> renderDots(BuiltList<Message> messages) {
    final List<Widget> dots = [];
    for (int i = 0; i < messages.length; i++) {
      dots.add(pageDot(i));
    }
    return dots;
  }

  Container pageDot(int index) {
    return Container(
      width: 8.0,
      height: 8.0,
      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _current == index
            ? Color.fromRGBO(0, 0, 0, 0.9)
            : Color.fromRGBO(0, 0, 0, 0.4),
      ),
    );
  }
}
