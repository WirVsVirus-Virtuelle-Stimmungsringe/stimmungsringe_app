import 'package:built_collection/src/list.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:familiarise/data/message.dart';
import 'package:familiarise/pages/dashboard/bloc/dashboard_bloc.dart';
import 'package:familiarise/pages/dashboard/bloc/dashboard_state.dart';
import 'package:familiarise/repositories/avatar_repository.dart';
import 'package:familiarise/widgets/loading_spinner.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const double _avatarSize = 150;

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
      navigationBar: CupertinoNavigationBar(middle: Text('Nachrichten')),
      child: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color.fromRGBO(195, 11, 159, 0.8),
            const Color.fromRGBO(219, 106, 11, 0.8)
          ],
        )),
        child: foobar(),
      ),
    );
  }

  Widget foobar() {
    return BlocBuilder<DashboardBloc, DashboardState>(
      builder: (context, state) {
        if (state.hasDashboard) {
          return widgetFactory(state as StateWithDashboard);
        } else {
          return LoadingSpinner();
        }
      },
    );
  }

  Widget avatarImage(String senderUserId) {
    // FIXME
    final ImageProvider image = AvatarRepository().avatarImage(senderUserId);

    return Container(
      width: _avatarSize,
      height: _avatarSize,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: image,
          fit: BoxFit.cover,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(_avatarSize / 2),
        ),
        border: Border.all(
          color: CupertinoColors.white,
          width: 4.0,
        ),
      ),
    );
  }

  Widget widgetFactory(StateWithDashboard state) {
    final messageCount = state.inbox.messages.length;
    // return Text("meine Message Inbox count=" + state.inbox.messages.length.toString());

    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Container(
          //constraints: BoxConstraints.expand(height: 0.8),
          child: CarouselSlider(
            items: state.inbox.messages.map((message) {
              return Column(children: [
                Text("text: " + message.text),
                avatarImage(message.senderUserId),
                Text("sender userid: " + message.senderUserId),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Image.asset(
                    'assets/images/heart.png',
                    width: 57,
                    color: Color.fromRGBO(255, 255, 255, 1.0),
                  ),
                ),
              ]);
            }).toList(growable: false),
            options: CarouselOptions(
                height: 400,
                //autoPlay: true,
                //enlargeCenterPage: true,
                //viewportFraction: 1.0,
                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index;
                  });
                }),
          ),
        ),
        Row(children: renderDots(state.inbox.messages)),
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
