import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stimmungsringeapp/data/detail_pages.dart';
import 'package:stimmungsringeapp/data/freezed_classes.dart';
import 'package:stimmungsringeapp/data/sentiment.dart';
import 'package:stimmungsringeapp/global_constants.dart';
import 'package:stimmungsringeapp/repositories/dashboard_repository.dart';
import 'package:stimmungsringeapp/widgets/avatar_row.dart';

class OtherDetailPage extends StatelessWidget {
  final String otherUserId;
  final DashboardRepository dashboardRepository;
  OtherDetail _otherDetail;

  OtherDetailPage({this.dashboardRepository, this.otherUserId})
      : assert(otherUserId != null) {
    // FIXME

    loadOtherDetailPageData(otherUserId).then((details) {
      print("other details loaded - not used ATM " +
          details.user.toJson().toString());
    });

    this._otherDetail = OtherDetail(UserMinimal(otherUserId, "test test"),
        SentimentStatus(Sentiment("windy")), []);
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Wie geht es eigentlich ... '),
      ),
      child: SafeArea(
        child: _otherDetail != null ? buildContent() : makeSpinner(),
      ),
    );
  }

  Column buildContent() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        AvatarRow(
          name: _otherDetail.user.displayName,
          image: NetworkImage(avatarImageUrl(_otherDetail.user.userId)),
          avatarSentiment:
              SentimentUi.fromSentimentStatus(_otherDetail.sentimentStatus),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          child: Title(
            color: CupertinoColors.black,
            child: Text(
              '',
            ),
          ),
        ),
        Expanded(
          child: buildSuggestionsList(),
        )
      ],
    );
  }

  Widget makeSpinner() {
    return Center(
      child: CupertinoActivityIndicator(
        animating: true,
      ),
    );
  }

  Widget buildSuggestionRow(
      Suggestion suggestion, NetworkImage myAvatarImage, bool lastItem) {
    NetworkImage placeholder = NetworkImage(
        'https://1s83z11vs1os1aeaj31io68i-wpengine.netdna-ssl.com/wp-content/themes/mobsquad/img/avatar-fallback.jpg');
    Widget row = Container(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 15),
            child: CircleAvatar(
              backgroundImage: // placeholder
                  myAvatarImage,
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

  // deprecated
  ListView buildSuggestionsList() {
    NetworkImage placeholder = NetworkImage(
        'https://1s83z11vs1os1aeaj31io68i-wpengine.netdna-ssl.com/wp-content/themes/mobsquad/img/avatar-fallback.jpg');
    //var myAvatarImage =
    //    NetworkImage(avatarImageUrl(dashboard.myTile.user.userId));

    return ListView.builder(
      itemCount: _otherDetail.suggestions.length,
      itemBuilder: (context, index) {
        final suggestion = _otherDetail.suggestions[index];

        return buildSuggestionRow(
          suggestion,
          placeholder,
          index < _otherDetail.suggestions.length - 1,
        );
      },
    );
  }
}
