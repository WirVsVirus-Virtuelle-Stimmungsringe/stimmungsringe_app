import 'package:familiarise/config.dart';
import 'package:familiarise/data/available_avatars.dart';
import 'package:familiarise/session.dart';
import 'package:familiarise/utils/response.dart';
import 'package:http/http.dart' as http;

class AvatarRepository {
  static final AvatarRepository _singleton = AvatarRepository._internal();

  factory AvatarRepository() {
    return _singleton;
  }

  AvatarRepository._internal();

  Future<AvailableAvatars> availableAvatars() async {
    final http.Response response = await http.get(
      '${Config().backendUrl}/avatar/available',
      headers: {'X-User-ID': currentUserId},
    );

    assert(response.statusCode == 200,
        'load available avatars -> ${response.statusCode}');

    return AvailableAvatars.fromJson(
        decodeResponseBytesToJson(response.bodyBytes));
  }
}
