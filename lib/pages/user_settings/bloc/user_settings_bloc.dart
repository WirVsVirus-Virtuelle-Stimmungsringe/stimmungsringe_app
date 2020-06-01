import 'package:familiarise/data/available_avatars.dart';
import 'package:familiarise/data/user_settings.dart';
import 'package:familiarise/pages/user_settings/bloc/user_settings_event.dart';
import 'package:familiarise/pages/user_settings/bloc/user_settings_state.dart';
import 'package:familiarise/repositories/avatar_repository.dart';
import 'package:familiarise/repositories/onboarding_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserSettingsBloc extends Bloc<UserSettingsEvent, UserSettingsState> {
  final OnboardingRepository onboardingRepository;
  final AvatarRepository avatarRepository;

  UserSettingsBloc(this.onboardingRepository, this.avatarRepository) : super();

  @override
  UserSettingsState get initialState => UserSettingsUninitialized();

  @override
  Stream<UserSettingsState> mapEventToState(UserSettingsEvent event) async* {
    if (event is LoadUserSettings) {
      yield* mapLoadUserSettingsToState(event);
    } else if (event is SaveUserSettings) {
      yield* mapSaveUserSettingsToState(event);
    }
  }

  Stream<UserSettingsState> mapLoadUserSettingsToState(
      LoadUserSettings loadUserSettingsEvent) async* {
    if (state is UserSettingsLoading) {
      return;
    }
    yield UserSettingsLoading();
    final resolutions = await Future.wait([
      onboardingRepository.getUserSettings(),
      avatarRepository.availableAvatars()
    ]);

    final UserSettings userSettings = resolutions[0] as UserSettings;
    final AvailableAvatars availableAvatars =
        resolutions[1] as AvailableAvatars;
    yield UserSettingsLoaded(
      userSettings.userName,
      userSettings.hasName,
      userSettings.stockAvatar,
      availableAvatars.stockAvatars,
    );
  }

  Stream<UserSettingsState> mapSaveUserSettingsToState(
      SaveUserSettings event) async* {
    await onboardingRepository.updateUserSettings(
      event.userName,
      event.stockAvatar,
    );
    yield* mapLoadUserSettingsToState(LoadUserSettings());
  }

  @override
  void onTransition(
      Transition<UserSettingsEvent, UserSettingsState> transition) {
    super.onTransition(transition);
    print(transition);
  }
}
