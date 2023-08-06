import 'dart:io';

import 'package:app/contants/business_constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

typedef CustomPlaceholderWidgetBuilder = Widget Function(BuildContext context,
    {String? url, dynamic error, StackTrace? stackTrace});
mixin AppImage {
  static Widget universal(
    String path, {
    Key? key,
    File? file,
    BoxFit? fit,
    double? width,
    double? height,
    CustomPlaceholderWidgetBuilder? placeholder,
    bool? allowDrawingOutsideViewBox,
    Animation<double>? controller,
    bool? animate = true,
    bool matchTextDirection = false,
  }) {
    if (file != null) {
      return Image.file(
        file,
        key: key,
        fit: fit ?? BoxFit.contain,
        width: width,
        height: height,
      );
    }
    if (path.startsWith(RegExp(r'https?://'))) {
      return netWork(path,
          key: key,
          file: file,
          fit: fit,
          width: width,
          height: height,
          placeholder: placeholder);
    } else {
      return asset(
        path,
        key: key,
        file: file,
        fit: fit,
        width: width,
        height: height,
        placeholder: placeholder,
      );
    }
  }

  static Widget netWork(
    String path, {
    Key? key,
    File? file,
    BoxFit? fit,
    double? width,
    double? height,
    bool? isAvatar,
    CustomPlaceholderWidgetBuilder? placeholder,
  }) {
    if (path == "null" || path.isEmpty) {
      return Image.asset(
        isAvatar == true
            ? '${BusinessConstants.imgPathPrefix}/chat/avtar1.png'
            : '${BusinessConstants.imgPathPrefix}/chat/avtar1.png',
        width: width,
        height: height,
      );
    } else {
      return CachedNetworkImage(
        imageUrl: path,
        key: key,
        fit: fit,
        width: width,
        height: height,
        placeholder: placeholder != null
            ? (BuildContext context, String url) =>
                placeholder.call(context, url: url)
            : null,
        errorWidget: placeholder != null
            ? (BuildContext context, String url, dynamic error) =>
                placeholder.call(context, url: url, error: error)
            : null,
      );
    }
  }

  static Widget asset(
    String path, {
    Key? key,
    File? file,
    BoxFit? fit,
    double? width,
    double? height,
    Color? color,
    CustomPlaceholderWidgetBuilder? placeholder,
  }) {
    if (file != null) {
      return Image.file(
        file,
        key: key,
        fit: fit ?? BoxFit.contain,
        width: width,
        height: height,
        color: color,
      );
    }
    return Image.asset(
      path,
      key: key,
      fit: fit ?? BoxFit.contain,
      color: color,
      width: width,
      height: height,
    );
  }
}
