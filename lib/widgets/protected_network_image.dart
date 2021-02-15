import 'package:cached_network_image/cached_network_image.dart';
import 'package:familiarise/utils/api_headers.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

ImageProvider makeProtectedNetworkImage(String userId, String url,
    {Map<String, String> headers}) {
  final allHeaders = {...?headers, ...authenticated(userId)};

  return CachedNetworkImageProvider(url, headers: allHeaders);
}
