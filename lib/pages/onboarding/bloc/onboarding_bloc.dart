import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stimmungsringeapp/data/onboarding.dart';
import 'package:stimmungsringeapp/pages/onboarding/bloc/bloc.dart';
import 'package:stimmungsringeapp/repositories/repositories.dart';
import 'package:stimmungsringeapp/session.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  final OnboardingRepository onboardingRepository;

  OnboardingBloc({@required this.onboardingRepository})
      : assert(onboardingRepository != null);

  @override
  OnboardingState get initialState => CheckingUser();

  @override
  Stream<OnboardingState> mapEventToState(OnboardingEvent event) async* {
    if (event is CheckUser) {
      yield* _mapCheckUserToState(event);
    } else if (event is BeginStartNewGroup) {
      yield* _mapBeginStartNewGroupToState(event);
    } else if (event is StartNewGroup) {
      yield* _mapStartNewGroupToState(event);
    } else if (event is BeginJoinGroup) {
      yield* _mapBeginJoinGroupToState(event);
    } else if (event is SearchGroup) {
      yield* _mapSearchGroupToState(event);
    } else if (event is LeaveGroup) {
      yield* _mapLeaveGroupToState(event);
    }
  }

  Stream<OnboardingState> _mapCheckUserToState(CheckUser checkUser) async* {
    final SigninUserResponse signinUserResponse =
        await onboardingRepository.signin(currentDeviceIdentifier);
    currentUserId = signinUserResponse.userId;

    if (signinUserResponse.hasGroup) {
      currentGroupId = signinUserResponse.groupId;
      currentGroupName = signinUserResponse.groupName;

      yield GotoDashboard();
    } else {
      yield OnboardingIntro();
    }
  }

  Stream<OnboardingState> _mapBeginStartNewGroupToState(
      BeginStartNewGroup beginStartNewGroup) async* {
    yield StartNewGroupInitial();
  }

  Stream<OnboardingState> _mapStartNewGroupToState(
      StartNewGroup startNewGroup) async* {
    final StartNewGroupResponse startNewGroupResponse =
        await onboardingRepository.startNewGroup(startNewGroup.groupName);
    if (startNewGroupResponse != null) {
      currentGroupId = startNewGroupResponse.groupId;
      currentGroupName = startNewGroupResponse.groupName;
      yield StartNewGroupSuccess(groupName: startNewGroup.groupName);
    } else {
      yield StartNewGroupFailedConflict(groupName: startNewGroup.groupName);
      yield StartNewGroupInitial();
    }
  }

  Stream<OnboardingState> _mapBeginJoinGroupToState(
      BeginJoinGroup beginJoinGroup) async* {
    yield FindGroupInitial();
  }

  Stream<OnboardingState> _mapSearchGroupToState(
      SearchGroup searchGroup) async* {
    final FindGroupResponse findGroupResponse = await onboardingRepository
        .findGroupByName(searchGroup.groupCode); // note groupCode==groupName

    if (findGroupResponse != null) {
      await onboardingRepository.joinGroup(findGroupResponse.groupId);
      currentGroupId = findGroupResponse.groupId;
      currentGroupName = findGroupResponse.groupName;
      yield FindGroupSuccess(groupName: findGroupResponse.groupName);
    } else {
      yield FindGroupNotFound();
      yield FindGroupInitial();
    }
  }

  Stream<OnboardingState> _mapLeaveGroupToState(LeaveGroup leaveGroup) async* {
    await onboardingRepository.leaveGroup(leaveGroup.groupId);
    yield CheckingUser();
  }

  @override
  void onTransition(Transition<OnboardingEvent, OnboardingState> transition) {
    super.onTransition(transition);
    print(transition);
  }
}
