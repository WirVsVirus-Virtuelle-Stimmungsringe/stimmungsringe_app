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
      final settings =
          await onboardingRepository.getGroupSettings(currentGroupId);
      yield ShowCurrentSettings(settings.groupName, settings.groupCode);
    } else if (event is UpdateGroupSettings) {
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
