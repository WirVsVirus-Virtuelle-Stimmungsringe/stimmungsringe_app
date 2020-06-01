import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:familiarise/config.dart';
import 'package:familiarise/data/available_avatars.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class AvatarRepository {
  static final AvatarRepository _singleton = AvatarRepository._internal();

  factory AvatarRepository() {
    return _singleton;
  }

  AvatarRepository._internal();

  Future<List<ImageProvider<CachedNetworkImageProvider>>> stockAvatars(
      String userId) async {
    final http.Response response = await http.get(
      '${Config().backendUrl}/avatar/available',
      headers: {'X-User-ID': userId},
    );

    assert(response.statusCode == 200,
        'load available avatars -> ${response.statusCode}');

    final AvailableAvatars availableAvatars = AvailableAvatars.fromJson(
        json.decode(response.body) as Map<String, dynamic>);

    return availableAvatars.stockAvatars
        .map((avatarName) => CachedNetworkImageProvider(
            '${Config().backendUrl}/avatar/stock/$avatarName'))
        .toList(growable: false);
  }
}
