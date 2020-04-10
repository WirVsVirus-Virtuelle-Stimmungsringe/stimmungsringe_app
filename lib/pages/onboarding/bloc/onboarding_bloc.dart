import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stimmungsringeapp/data/onboarding.dart';
import 'package:stimmungsringeapp/global_constants.dart';
import 'package:stimmungsringeapp/pages/onboarding/bloc/bloc.dart';
import 'package:stimmungsringeapp/repositories/repositories.dart';

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
          await onboardingRepository.signin(forceOnboarding ? 'abba' : '1234');

      if (signinUserResponse.hasGroup) {
        yield GotoDashboard();
      } else {
        yield FindGroupInitial();
      }
    }

    if (event is SearchGroup) {
      final bool groupFound =
          await onboardingRepository.findGroupByCode(event.groupCode);

      if (groupFound) {
        yield FindGroupSuccess();
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
