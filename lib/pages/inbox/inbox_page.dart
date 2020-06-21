import 'package:built_collection/built_collection.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:familiarise/data/message.dart';
import 'package:familiarise/pages/dashboard/bloc/dashboard_bloc.dart';
import 'package:familiarise/pages/dashboard/bloc/dashboard_state.dart';
import 'package:familiarise/widgets/avatar.dart';
import 'package:familiarise/widgets/loading_spinner.dart';
import 'package:familiarise/widgets/protected_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
  static const _colorTransparent = Color(0x00000000);
  int _currentSlideIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: const [
            Color.fromRGBO(213, 0, 163, 1),
            Color.fromRGBO(235, 102, 0, 1)
          ],
        ),
      ),
      child: CupertinoPageScaffold(
        backgroundColor: _colorTransparent,
        navigationBar: CupertinoNavigationBar(
          actionsForegroundColor: CupertinoColors.white,
          backgroundColor: _colorTransparent,
          border: Border.all(color: _colorTransparent, width: 0),
        ),
        child: SafeArea(
          child: _body(),
        ),
      ),
    );
  }

  Widget _body() {
    return BlocBuilder<DashboardBloc, DashboardState>(
      builder: (context, state) {
        if (state.hasDashboard) {
          return _bodyContent(state as StateWithDashboard);
        } else {
          return LoadingSpinner();
        }
      },
    );
  }

  Widget _bodyContent(StateWithDashboard state) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        children: <Widget>[
          Flexible(
            child: Center(
              child: CarouselSlider(
                options: CarouselOptions(
                  height: 500,
                  enableInfiniteScroll: false,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _currentSlideIndex = index;
                    });
                  },
                ),
                items: state.inbox.messages
                    .map(_carouselEntry)
                    .toList(growable: false),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: _dots(state.inbox.messages),
          ),
        ],
      ),
    );
  }

  Widget _carouselEntry(Message message) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Text(
          message.text,
          style: TextStyle(
            fontSize: 35,
            fontWeight: FontWeight.bold,
            color: CupertinoColors.white,
          ),
          textAlign: TextAlign.center,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Avatar(
            image: makeProtectedNetworkImage(
              message.senderUser.userId,
              message.senderUser.avatarUrl,
            ),
            size: 200,
          ),
        ),
        Icon(
          FontAwesomeIcons.solidHeart,
          size: 60,
          color: CupertinoColors.white,
        ),
      ],
    );
  }

  List<Widget> _dots(BuiltList<Message> messages) {
    final List<Widget> dots = [];
    for (int i = 0; i < messages.length; i++) {
      dots.add(_dot(i));
    }
    return dots;
  }

  Widget _dot(int index) {
    return Container(
      width: 12.0,
      height: 12.0,
      margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 6.0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _currentSlideIndex == index
            ? const Color.fromRGBO(255, 255, 255, 0.9)
            : const Color.fromRGBO(255, 255, 255, 0.4),
      ),
    );
  }
}
