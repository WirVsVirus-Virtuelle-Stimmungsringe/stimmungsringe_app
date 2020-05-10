import 'package:familiarise/pages/user_settings/bloc/user_settings_event.dart';
import 'package:familiarise/pages/user_settings/bloc/user_settings_state.dart';
import 'package:familiarise/repositories/onboarding_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserSettingsBloc extends Bloc<UserSettingsEvent, UserSettingsState> {
  final OnboardingRepository onboardingRepository;

  UserSettingsBloc(this.onboardingRepository);

  @override
  UserSettingsState get initialState => UserSettingsUninitialized();

  @override
  Stream<UserSettingsState> mapEventToState(UserSettingsEvent event) async* {
    if (event is LoadUserSettings) {
      yield* mapLoadUserSettingsToState(event);
    } else if (event is SaveUserSettings) {
      await onboardingRepository.updateUserSettings(event.userName);
      yield* mapLoadUserSettingsToState(LoadUserSettings());
    }
  }

  Stream<UserSettingsState> mapLoadUserSettingsToState(
      LoadUserSettings loadUserSettingsEvent) async* {
    if (state is UserSettingsLoading) {
      return;
    }
    yield UserSettingsLoading();
    final userSettings = await onboardingRepository.getUserSettings();
    yield ShowCurrentUserSettings(userSettings.userName, userSettings.hasName);
  }

  @override
  void onTransition(
      Transition<UserSettingsEvent, UserSettingsState> transition) {
    super.onTransition(transition);
    print(transition);
  }
}
