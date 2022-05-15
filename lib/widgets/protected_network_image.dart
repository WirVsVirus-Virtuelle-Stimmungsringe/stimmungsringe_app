import 'package:cached_network_image/cached_network_image.dart';
import 'package:familiarise/utils/api_headers.dart';
import 'package:familiarise/widgets/avatar_svg.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

ImageProvider makeProtectedNetworkImage(
  String userId,
  String url, {
  Map<String, String>? headers,
}) {
  final allHeaders = {...?headers, ...authenticated(userId)};

  return CachedNetworkImageProvider(url, headers: allHeaders);
}

SvgPictureFactory makeProtectedNetworkSvgPictureFactory(
  String userId,
  String url, {
  Map<String, String>? headers,
}) {
  final allHeaders = {...?headers, ...authenticated(userId)};

  return (double width, double height) => SvgPicture.network(
        url,
        headers: allHeaders,
        width: width,
        height: height,
      );
}
