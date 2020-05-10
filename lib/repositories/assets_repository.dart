import 'package:familiarise/config.dart';
import 'package:flutter/painting.dart';

class AssetsRepository {
  ImageProvider<NetworkImage> avatarImage(String userId) {
    return NetworkImage('${Config().backendUrl}/images/avatar/$userId');
  }
}
