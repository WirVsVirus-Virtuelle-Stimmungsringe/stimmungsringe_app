import 'package:familiarise/data/dashboard.dart';
import 'package:familiarise/data/sentiment.dart';
import 'package:familiarise/pages/dashboard/bloc/dashboard_bloc.dart';
import 'package:familiarise/pages/dashboard/bloc/dashboard_event.dart';
import 'package:familiarise/pages/dashboard/bloc/dashboard_state.dart';
import 'package:familiarise/widgets/avatar_row.dart';
import 'package:familiarise/widgets/loading_spinner.dart';
import 'package:familiarise/widgets/paragraph.dart';
import 'package:familiarise/widgets/protected_network_image.dart';
import 'package:familiarise/widgets/sentiment_icon_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SetMySentimentPage extends StatefulWidget {
  static const String routeUri = '/my-sentiment';

  static MapEntry<String, WidgetBuilder> route = MapEntry(
    routeUri,
    (context) => BlocProvider<DashboardBloc>.value(
      value: ModalRoute.of(context).settings.arguments as DashboardBloc,
      child: SetMySentimentPage(),
    ),
  );

  @override
  _SetMySentimentPageState createState() => _SetMySentimentPageState();
}

class _SetMySentimentPageState extends State<SetMySentimentPage> {
  Sentiment _sentiment;
  bool _sentimentTextTouched = false;
  int _enteredTextLength = 0;
  final _sentimentTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardBloc, DashboardState>(
        builder: (context, state) {
      if (state.hasDashboard) {
        final stateWithData = state as StateWithData;
        if (_sentiment == null) {
          _sentiment = stateWithData.dashboard.myTile.sentiment;
          _sentimentTextController.text =
              stateWithData.dashboard.myTile.sentimentText;
        }
        return _buildLoadedPage(context, state as StateWithData);
      } else {
        return LoadingSpinner();
      }
    });
  }

  Widget _buildLoadedPage(BuildContext context, StateWithData state) {
    final Dashboard dashboard = state.dashboard;
    const maxStatusTextLength = 20;

    return WillPopScope(
      onWillPop: () {
        final DashboardBloc dashboardBloc =
            BlocProvider.of<DashboardBloc>(context);
        dashboardBloc
            .add(SetNewSentiment(_sentiment, _sentimentTextController.text));
        return Future.value(true);
      },
      child: CupertinoPageScaffold(
        navigationBar: const CupertinoNavigationBar(
          middle: Text('Persönliches Wetter'),
        ),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              AvatarRow(
                name: dashboard.myTile.user.hasName
                    ? dashboard.myTile.user.displayName
                    : '',
                image: makeProtectedNetworkImage(
                  dashboard.myTile.user.userId,
                  dashboard.myTile.user.avatarUrl,
                ),
                avatarSentiment: _sentiment,
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                child: const Paragraph(
                  child: Text(
                    'Welches Wettersymbol passt gerade am besten zu deiner Stimmung?',
                    textAlign: TextAlign.start,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              ..._allSentiments(context),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                child: Paragraph(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Paragraph(
                        child: Text(
                          'Wie würdest du deine Stimmung kurz beschreiben?',
                          textAlign: TextAlign.start,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      CupertinoTextField(
                        placeholder: "Beschreibung",
                        controller: _sentimentTextController,
                        maxLength: maxStatusTextLength,
                        onChanged: (enteredText) {
                          setState(() {
                            _enteredTextLength = enteredText.length;
                            _sentimentTextTouched = true;
                          });
                        },
                        suffix: Padding(
                          padding: const EdgeInsets.only(right: 4.0),
                          child: Text(
                            "$_enteredTextLength/$maxStatusTextLength",
                            style: const TextStyle(
                              fontSize: 14,
                              color: CupertinoColors.inactiveGray,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Iterable<Widget> _allSentiments(BuildContext context) {
    final slices = _toPaddedSlices<Sentiment, Widget>(
      allValues: Sentiment.values,
      mapper: (currSentiment) => SentimentIconButton(
        sentiment: currSentiment,
        isSelected: _sentiment == currSentiment,
        onTap: (selectedSentiment) {
          setState(() {
            _sentiment = selectedSentiment;
            if (!_sentimentTextTouched) {
              _sentimentTextController.text =
                  selectedSentiment.defaultSentimentText;
            }
          });
        },
      ),
      sliceLength: 3,
      paddingValueFactory: () => Container(),
    );

    return slices.map(
      (rowSentiments) => Row(
        children: rowSentiments
            .map(
              (currSentimentButton) => Expanded(
                child: Center(
                  child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: currSentimentButton),
                ),
              ),
            )
            .toList(growable: false),
      ),
    );
  }

  List<List<U>> _toPaddedSlices<T, U>({
    Iterable<T> allValues,
    U Function(T) mapper,
    int sliceLength,
    U Function() paddingValueFactory,
  }) {
    final slices = <List<U>>[];

    var currSlice = allValues.take(sliceLength);
    var remainingValues = allValues.skip(sliceLength);

    while (currSlice.isNotEmpty) {
      final List<U> mappedSlice = currSlice.map(mapper).toList();

      if (mappedSlice.length < sliceLength) {
        for (var i = 0; i < sliceLength - mappedSlice.length; i++) {
          mappedSlice.add(paddingValueFactory());
        }
      }

      slices.add(mappedSlice);

      currSlice = remainingValues.take(3);
      remainingValues = remainingValues.skip(3);
    }

    return slices;
  }
}
