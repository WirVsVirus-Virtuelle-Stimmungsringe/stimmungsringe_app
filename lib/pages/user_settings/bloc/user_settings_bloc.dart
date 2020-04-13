import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stimmungsringeapp/pages/user_settings/bloc/bloc.dart';
import 'package:stimmungsringeapp/repositories/onboarding_repository.dart';

class UserSettingsBloc extends Bloc<UserSettingsEvent, UserSettingsState> {
  final OnboardingRepository onboardingRepository;

  UserSettingsBloc(this.onboardingRepository);

  @override
  UserSettingsState get initialState => UserSettingsLoading();

  @override
  Stream<UserSettingsState> mapEventToState(UserSettingsEvent event) async* {
    if (event is LoadUserSettings) {
      final userSettings = await onboardingRepository.getUserSettings();
      yield ShowCurrentUserSettings(userSettings.userName);
    } else if (event is UpdateUserSettings) {
      await onboardingRepository.updateUserSettings(event.userName);
    }
  }

  @override
  void onTransition(
      Transition<UserSettingsEvent, UserSettingsState> transition) {
    super.onTransition(transition);
    print(transition);
  }
}
