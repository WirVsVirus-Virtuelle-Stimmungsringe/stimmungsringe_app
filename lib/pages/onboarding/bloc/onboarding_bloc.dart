import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stimmungsringeapp/global_constants.dart';
import 'package:stimmungsringeapp/pages/onboarding/bloc/bloc.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  @override
  OnboardingState get initialState => CheckingUser();

  @override
  Stream<OnboardingState> mapEventToState(OnboardingEvent event) async* {
    if (event is CheckUser) {
      if (forceOnboarding) {
        yield FindGroupInitial();
      } else {
        yield GotoDashboard();
      }
    }

    if (event is SearchGroup) {
      await Future<void>.delayed(const Duration(seconds: 1));
      if (event.groupCode == "1111") {
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
