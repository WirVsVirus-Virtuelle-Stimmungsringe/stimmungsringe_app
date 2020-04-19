import 'package:flutter/painting.dart';
import 'package:stimmungsringeapp/config.dart';

class AssetsRepository {
  ImageProvider<NetworkImage> avatarImage(String userId) {
    return NetworkImage('${Config().backendUrl}/images/avatar/$userId');
  }
}
