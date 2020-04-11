import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stimmungsringeapp/data/onboarding.dart';
import 'package:stimmungsringeapp/pages/onboarding/bloc/bloc.dart';
import 'package:stimmungsringeapp/repositories/repositories.dart';
import 'package:stimmungsringeapp/session.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  final OnboardingRepository onboardingRepository;

  OnboardingBloc({this.onboardingRepository})
      : assert(onboardingRepository != null);

  @override
  OnboardingState get initialState => CheckingUser();

  @override
  Stream<OnboardingState> mapEventToState(OnboardingEvent event) async* {
    if (event is CheckUser) {
      final SigninUserResponse signinUserResponse =
          await onboardingRepository.signin(currentDeviceIdentifier);
      currentUserId = signinUserResponse.userId;

      if (signinUserResponse.hasGroup) {
        currentGroupId = signinUserResponse.groupId;
        currentGroupName = signinUserResponse.groupName;

        yield GotoDashboard();
      } else {
        yield FindGroupInitial();
      }
    }

    if (event is SearchGroup) {
      final FindGroupResponse findGroupResponse = await onboardingRepository
          .findGroupByName(event.groupCode); // note groupCode==groupName

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
  }

  @override
  void onTransition(Transition<OnboardingEvent, OnboardingState> transition) {
    super.onTransition(transition);
    print(transition);
  }
}
