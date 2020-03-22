const _backendBaseUrl =
    'http://wvsvhackvirtuellestimmungsringe-env.eba-eug7bzt6.eu-central-1.elasticbeanstalk.com/stimmungsring';

const sampleUserMutti = 'cafecafe-b855-46ba-b907-321d2d38beef';
const sampleUserTimmy = '12340000-b855-46ba-b907-321d2d38feeb';

String restUrlDashboard() {
  return _backendBaseUrl + '/dashboard';
}

String avatarImageUrl(String userId) {
  return _backendBaseUrl + '/images/avatar/' + userId;
}

String restUrlMyStatus() {
  return _backendBaseUrl + '/mystatuspage';
}

String restUrlOtherStatus(String userId) {
  return _backendBaseUrl + '/otherstatuspage/' + userId;
}

/**
 * use to update status
 */
String restUrlStatus() {
  return _backendBaseUrl + '/mystatus';
}
