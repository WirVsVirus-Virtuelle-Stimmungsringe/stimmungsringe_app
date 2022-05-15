import 'dart:async';

import 'package:familiarise/data/available_avatars.dart';
import 'package:familiarise/pages/loading_spinner_page.dart';
import 'package:familiarise/pages/onboarding/onboarding_start_page.dart';
import 'package:familiarise/pages/user_settings/bloc/user_settings_bloc.dart';
import 'package:familiarise/pages/user_settings/bloc/user_settings_event.dart';
import 'package:familiarise/pages/user_settings/bloc/user_settings_state.dart';
import 'package:familiarise/session.dart';
import 'package:familiarise/widgets/avatar_button.dart';
import 'package:familiarise/widgets/avatar_widget_factory.dart';
import 'package:familiarise/widgets/paragraph.dart';
import 'package:familiarise/widgets/text_field_with_max_length.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserSettingsPage extends StatefulWidget {
  static const String routeUri = '/user-settings';

  static MapEntry<String, WidgetBuilder> makeRoute(
    UserSettingsBloc userSettingsBloc,
  ) =>
      MapEntry(
        routeUri,
        (BuildContext context) => BlocProvider<UserSettingsBloc>.value(
          value: userSettingsBloc,
          child: UserSettingsPage(),
        ),
      );

  @override
  _UserSettingsPageState createState() => _UserSettingsPageState();
}

class _UserSettingsPageState extends State<UserSettingsPage> {
  final _userNameController = TextEditingController();
  String? _selectedAvatar;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    BlocProvider.of<UserSettingsBloc>(context).add(LoadUserSettings());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserSettingsBloc, UserSettingsState>(
      builder: (context, state) {
        if (state is UserSettingsLoading) {
          return LoadingSpinnerPage();
        }
        if (state is UserSettingsLoaded) {
          return WillPopScope(
            onWillPop: () {
              BlocProvider.of<UserSettingsBloc>(context).add(
                SaveUserSettings(
                  userName: _userNameController.text,
                  stockAvatar: _selectedAvatar,
                ),
              );
              return Future.value(true);
            },
            child: _buildPageContent(state),
          );
        }

        print("Not rendering state in user settings page ${state.toString()}");
        return LoadingSpinnerPage();
      },
      listener: (context, state) {
        if (state is UserSettingsLoaded) {
          setState(() {
            _userNameController.text = state.userName ?? '';
            _selectedAvatar = state.stockAvatar;
          });
        }

        if (state is GotoOnboarding) {
          Navigator.of(context)
              .pushReplacementNamed(OnboardingStartPage.routeUri);
        }
      },
    );
  }

  Widget _buildPageContent(UserSettingsLoaded state) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Benutzereinstellungen'),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: CustomScrollView(
            physics: const ClampingScrollPhysics(),
            slivers: <Widget>[
              _buildInputField(),
              _buildAvatarGrid(state),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField() {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.only(top: 16),
            child: Text(
              'Welchen Namen willst du dir geben?',
              textAlign: TextAlign.start,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Paragraph(
            child: TextFieldWithMaxLength(
              maxLength: 25,
              placeholder: 'Lasse andere wissen, wie du heißt!',
              controller: _userNameController,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAvatarGrid(UserSettingsLoaded state) {
    return SliverPadding(
      padding: const EdgeInsets.only(top: 24, bottom: 8),
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final avatar = state.availableAvatars.elementAt(index);

            return _buildAvatar(avatar);
          },
          childCount: state.availableAvatars.length,
        ),
      ),
    );
  }

  Widget _buildAvatar(StockAvatar avatar) {
    return AvatarButton(
      avatarWidgetFactory: makeAvatarSvgWidgetFactory(
        userId: currentUserId,
        avatarSvgUrl: avatar.avatarSvgUrl,
      ),
      selected: avatar.avatarName == _selectedAvatar,
      onAvatarTap: () {
        setState(() {
          _selectedAvatar = avatar.avatarName;
        });
      },
    );
  }
}
