import 'package:familiarise/pages/group_settings/bloc/group_settings_event.dart';
import 'package:familiarise/pages/group_settings/bloc/group_settings_state.dart';
import 'package:familiarise/repositories/onboarding_repository.dart';
import 'package:familiarise/session.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GroupSettingsBloc extends Bloc<GroupSettingsEvent, GroupSettingsState> {
  final OnboardingRepository onboardingRepository;

  GroupSettingsBloc(this.onboardingRepository) : super(GroupSettingsLoading());

  @override
  Stream<GroupSettingsState> mapEventToState(GroupSettingsEvent event) async* {
    if (event is LoadSettings) {
      final groupSettings =
          await onboardingRepository.getGroupSettings(currentGroupId!);
      yield ShowCurrentGroupSettings(
        groupSettings.groupName,
        groupSettings.groupCode,
      );
    } else if (event is SaveGroupSettings) {
      await onboardingRepository.updateGroupSettings(
        currentGroupId!,
        event.groupName,
      );
    } else if (event is LeaveGroup) {
      await onboardingRepository.leaveGroup(currentGroupId!);
      currentGroupId = null;
      yield GotoOnboarding();
    }
  }

  @override
  void onTransition(
    Transition<GroupSettingsEvent, GroupSettingsState> transition,
  ) {
    super.onTransition(transition);
    print(transition);
  }
}
