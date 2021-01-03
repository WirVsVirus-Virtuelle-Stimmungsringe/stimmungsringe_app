import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/painting.dart';

ImageProvider makeProtectedNetworkImage(String userId, String url,
    {Map<String, String> headers}) {
  final allHeaders = {...?headers, 'X-User-ID': userId};

  return CachedNetworkImageProvider(url, headers: allHeaders);
}
