import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stimmungsringeapp/pages/group_settings/bloc/bloc.dart';
import 'package:stimmungsringeapp/repositories/onboarding_repository.dart';
import 'package:stimmungsringeapp/session.dart';

class GroupSettingsBloc extends Bloc<GroupSettingsEvent, GroupSettingsState> {
  final OnboardingRepository onboardingRepository;

  GroupSettingsBloc(this.onboardingRepository);

  @override
  GroupSettingsState get initialState => SettingsLoading();

  @override
  Stream<GroupSettingsState> mapEventToState(GroupSettingsEvent event) async* {
    if (event is LoadSettings) {
      final groupSettings =
          await onboardingRepository.getGroupSettings(currentGroupId);
      final userSettings = await onboardingRepository.getUserSettings();
      yield ShowCurrentSettings(groupSettings.groupName,
          groupSettings.groupCode, userSettings.userName);
    } else if (event is UpdateGroupSettings) {
      await onboardingRepository.updateUserSettings(event.userName);
      await onboardingRepository.updateGroupSettings(
          currentGroupId, event.groupName);
    } else if (event is LeaveGroup) {
      await onboardingRepository.leaveGroup(currentGroupId);
      currentGroupId = null;
      yield GotoOnboarding();
    }
  }

  @override
  void onTransition(
      Transition<GroupSettingsEvent, GroupSettingsState> transition) {
    super.onTransition(transition);
    print(transition);
  }
}
