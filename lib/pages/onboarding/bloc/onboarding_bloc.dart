import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stimmungsringeapp/pages/onboarding/bloc/bloc.dart';
import 'package:stimmungsringeapp/repositories/repositories.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  final UserRepository userRepository;

  OnboardingBloc({this.userRepository}) : assert(userRepository != null);

  @override
  OnboardingState get initialState => CheckingUser();

  @override
  Stream<OnboardingState> mapEventToState(OnboardingEvent event) async* {
    if (event is CheckUser) {
      final bool isUserMemberOfAGroup =
          await userRepository.isUserMemberOfGroup();

      if (isUserMemberOfAGroup) {
        yield GotoDashboard();
      } else {
        yield FindGroupInitial();
      }
    }

    if (event is SearchGroup) {
      final bool groupFound =
          await userRepository.findGroupByCode(event.groupCode);

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
