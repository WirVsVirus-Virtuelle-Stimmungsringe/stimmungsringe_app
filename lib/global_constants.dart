enum AppEnv { iOSSimulator, localNetwork, prod }

// Pick your environment here
const AppEnv currentDevEnv = AppEnv.iOSSimulator;

const bool forceOnboarding = true;

const String backendUrlIOSSimulator = 'http://localhost:5000/stimmungsring';
const String backendUrlLocalNetwork =
    'http://192.168.178.20:5000/stimmungsring';
const String backendUrlProd =
    'http://wvsvhackvirtuellestimmungsringe-env.eba-eug7bzt6.eu-central-1.elasticbeanstalk.com/stimmungsring';

String backendUrlForEnv(final AppEnv appEnv) {
  switch (appEnv) {
    case AppEnv.iOSSimulator:
      return backendUrlIOSSimulator;
    case AppEnv.localNetwork:
      return backendUrlLocalNetwork;
    default:
      return backendUrlProd;
  }
}

final String backendBaseUrl = backendUrlForEnv(currentDevEnv);

//const String sampleUserMutti = 'cafecafe-b855-46ba-b907-321d2d38beef';
// note available on EBS yet
//const String sampleUserVatti = 'deadbeef-b855-46ba-b907-321d01010101';
//const String sampleUserTimmy = '12340000-b855-46ba-b907-321d2d38feeb';

String avatarImageUrl(String userId) {
  return '$backendBaseUrl/images/avatar/$userId';
}

Future<void> chaosMonkeyDelayAsync() async {
  if (currentDevEnv != AppEnv.prod) {
    await Future<void>.delayed(const Duration(seconds: 1));
  }
}
