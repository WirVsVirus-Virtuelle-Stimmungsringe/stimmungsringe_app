import 'package:familiarise/data/dashboard.dart';
import 'package:familiarise/data/sentiment.dart';
import 'package:familiarise/pages/dashboard/bloc/dashboard_bloc.dart';
import 'package:familiarise/pages/dashboard/bloc/dashboard_event.dart';
import 'package:familiarise/pages/dashboard/bloc/dashboard_state.dart';
import 'package:familiarise/widgets/avatar_row.dart';
import 'package:familiarise/widgets/loading_spinner.dart';
import 'package:familiarise/widgets/protected_network_image.dart';
import 'package:familiarise/widgets/sentiment_icon_button.dart';
import 'package:familiarise/widgets/text_field_with_max_length.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SetMySentimentPage extends StatefulWidget {
  static const String routeUri = '/my-sentiment';

  static MapEntry<String, WidgetBuilder> route = MapEntry(
    routeUri,
    (context) => BlocProvider<DashboardBloc>.value(
      value: ModalRoute.of(context)!.settings.arguments! as DashboardBloc,
      child: SetMySentimentPage(),
    ),
  );

  @override
  _SetMySentimentPageState createState() => _SetMySentimentPageState();
}

class _SetMySentimentPageState extends State<SetMySentimentPage> {
  Sentiment? _sentiment;
  bool _sentimentTextTouched = false;
  final _sentimentTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardBloc, DashboardState>(
      builder: (context, state) {
        if (state.hasDashboard) {
          final stateWithData = state as StateWithData;
          if (_sentiment == null) {
            _sentiment = stateWithData.dashboard!.myTile.sentiment;
            _sentimentTextController.text =
                stateWithData.dashboard!.myTile.sentimentText;
          }
          return _buildLoadedPage(context, state as StateWithData);
        } else {
          return LoadingSpinner();
        }
      },
    );
  }

  Widget _buildLoadedPage(BuildContext context, StateWithData state) {
    final Dashboard dashboard = state.dashboard!;

    return WillPopScope(
      onWillPop: () {
        if (_sentiment != null) {
          final DashboardBloc dashboardBloc =
              BlocProvider.of<DashboardBloc>(context);
          dashboardBloc
              .add(SetNewSentiment(_sentiment!, _sentimentTextController.text));
        }
        return Future.value(true);
      },
      child: CupertinoPageScaffold(
        navigationBar: const CupertinoNavigationBar(
          middle: Text('Meine Stimmung'),
        ),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              AvatarRow(
                name: dashboard.myTile.user.hasName
                    ? dashboard.myTile.user.displayName!
                    : '',
                image: makeProtectedNetworkImage(
                  dashboard.myTile.user.userId,
                  dashboard.myTile.user.avatarUrl,
                ),
                avatarSentiment: _sentiment!,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ..._buildWeatherPicker(),
                        ..._buildSentimentTextInput(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildWeatherPicker() {
    return <Widget>[
      const Padding(
        padding: EdgeInsets.symmetric(vertical: 16),
        child: Text(
          'Welches Wetter-Symbol entspricht deiner aktuellen Stimmung?',
          textAlign: TextAlign.start,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      ..._buildAllSentimentsGrid(context),
    ];
  }

  List<Widget> _buildSentimentTextInput() {
    const maxStatusTextLength = 20;

    return <Widget>[
      const Padding(
        padding: EdgeInsets.symmetric(vertical: 16),
        child: Text(
          'Wie würdest du deine Stimmung kurz beschreiben?',
          textAlign: TextAlign.start,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      TextFieldWithMaxLength(
        placeholder: "Beschreibung",
        maxLength: maxStatusTextLength,
        controller: _sentimentTextController,
        onChanged: (enteredText) {
          setState(() {
            _sentimentTextTouched = true;
          });
        },
      ),
    ];
  }

  Iterable<Widget> _buildAllSentimentsGrid(BuildContext context) {
    final slices = _toPaddedSlices<Sentiment, Widget>(
      allValues: Sentiment.values,
      mapper: _makeIconButtonForSentiment,
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
                    child: currSentimentButton,
                  ),
                ),
              ),
            )
            .toList(growable: false),
      ),
    );
  }

  Widget _makeIconButtonForSentiment(Sentiment sentiment) {
    return SentimentIconButton(
      sentiment: sentiment,
      isSelected: _sentiment == sentiment,
      onTap: (selectedSentiment) {
        setState(() {
          _sentiment = selectedSentiment;
          if (!_sentimentTextTouched) {
            _sentimentTextController.text =
                selectedSentiment.defaultSentimentText;
          }
        });
      },
    );
  }

  List<List<U>> _toPaddedSlices<T, U>({
    required Iterable<T> allValues,
    required U Function(T) mapper,
    required int sliceLength,
    required U Function() paddingValueFactory,
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
