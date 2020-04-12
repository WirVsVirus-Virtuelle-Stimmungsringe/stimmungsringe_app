import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stimmungsringeapp/data/freezed_classes.dart';
import 'package:stimmungsringeapp/global_constants.dart';
import 'package:stimmungsringeapp/pages/dashboard/bloc/bloc.dart';
import 'package:stimmungsringeapp/pages/other_detail/bloc/bloc.dart';
import 'package:stimmungsringeapp/repositories/dashboard_repository.dart';
import 'package:stimmungsringeapp/widgets/avatar_row.dart';
import 'package:stimmungsringeapp/widgets/loading_spinner_widget.dart';

class OtherDetailPage extends StatelessWidget {
  static final String routeUri = '/other-detail-page';

  static MapEntry<String, WidgetBuilder> makeRoute(
          DashboardRepository dashboardRepository) =>
      MapEntry(
        routeUri,
        (BuildContext context) {
          final args =
              ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
          final dashboardBloc = args['dashboardBloc'] as DashboardBloc;
          final otherUserId = args['otherUserId'] as String;

          return BlocProvider.value(
            value: dashboardBloc,
            child: BlocProvider<OtherDetailPageBloc>(
              create: (context) =>
                  OtherDetailPageBloc(dashboardRepository: dashboardRepository),
              child: OtherDetailPage(
                otherUserId: otherUserId,
              ),
            ),
          );
        },
      );

  final String otherUserId;

  const OtherDetailPage({@required this.otherUserId})
      : assert(otherUserId != null);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<OtherDetailPageBloc>(context)
        .add(FetchOtherDetailPage(otherUserId));

    return CupertinoPageScaffold(
        navigationBar: const CupertinoNavigationBar(
          middle: Text('Wie geht es eigentlich ... '),
        ),
        child: SafeArea(
          child: BlocBuilder<OtherDetailPageBloc, OtherDetailPageState>(
              builder: (context, state) {
            if (state is OtherDetailPageLoaded) {
              return buildContent();
            } else {
              return LoadingSpinnerWidget();
            }
          }),
        ));
  }

  Column buildContent() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        BlocBuilder<OtherDetailPageBloc, OtherDetailPageState>(
            builder: (context, state) {
          if (state is OtherDetailPageLoaded) {
            return AvatarRow(
              name: state.otherDetail.user.displayName,
              image:
                  NetworkImage(avatarImageUrl(state.otherDetail.user.userId)),
              avatarSentiment: state.otherDetail.sentiment,
            );
          } else {
            return LoadingSpinnerWidget();
          }
        }),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          child: Title(
            color: CupertinoColors.black,
            child: const Text(
              '',
            ),
          ),
        ),
        Expanded(child: BlocBuilder<OtherDetailPageBloc, OtherDetailPageState>(
            builder: (context, state) {
          if (state is OtherDetailPageLoaded) {
            // return buildSuggestionsList(state.otherDetail);
          }

          return Container();
        }))
      ],
    );
  }

  ListView buildSuggestionsList(OtherDetail otherDetail) {
    const NetworkImage placeholder = NetworkImage(
        'https://1s83z11vs1os1aeaj31io68i-wpengine.netdna-ssl.com/wp-content/themes/mobsquad/img/avatar-fallback.jpg');
    //final NetworkImage myAvatarImage =
    //    NetworkImage(avatarImageUrl(dashboard.myTile.user.userId));

    return ListView.builder(
      itemCount: otherDetail.suggestions.length,
      itemBuilder: (context, index) {
        final suggestion = otherDetail.suggestions[index];

        return buildSuggestionRow(
          suggestion,
          placeholder,
          lastItem: index < otherDetail.suggestions.length - 1,
        );
      },
    );
  }

  Widget buildSuggestionRow(Suggestion suggestion, NetworkImage myAvatarImage,
      {bool lastItem}) {
    final Widget row = Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: CircleAvatar(
              backgroundImage: myAvatarImage,
            ),
          ),
          Expanded(child: Text(suggestion.text))
        ],
      ),
    );

    if (!lastItem) {
      return row;
    }

    return Column(
      children: <Widget>[
        row,
        Padding(
          padding: const EdgeInsets.only(
            left: 60,
            right: 16,
          ),
          child: Container(
            height: 1,
            color: const Color(0xFFD9D9D9),
          ),
        ),
      ],
    );
  }
}
