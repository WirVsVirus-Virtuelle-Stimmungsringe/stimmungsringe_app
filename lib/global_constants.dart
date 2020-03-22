const _backendBaseUrl =
    'http://wvsvhackvirtuellestimmungsringe-env.eba-eug7bzt6.eu-central-1.elasticbeanstalk.com/stimmungsring';

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
