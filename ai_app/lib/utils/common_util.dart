import 'dart:convert';
import 'dart:typed_data';

import 'package:app/contants/business_constants.dart';
import 'package:flustars/flustars.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CommonUtil {
  static bool isLogin() {
    return !ObjectUtil.isEmptyString(
        SpUtil.getString(BusinessConstants.tokenKey));
  }

  // md5加密
  static String generateMd5(String data) {
    Uint8List content = const Utf8Encoder().convert(data);
    Digest digest = md5.convert(content);
    return digest.toString();
  }

  /// 十六进制颜色，
  /// hex, 十六进制值，例如：0xffffff,
  /// alpha, 透明度 [0.0,1.0]
  static Color hexColor(int hex, {double alpha = 1}) {
    if (alpha < 0) {
      alpha = 0;
    } else if (alpha > 1) {
      alpha = 1;
    }
    return Color.fromRGBO((hex & 0xFF0000) >> 16, (hex & 0x00FF00) >> 8,
        (hex & 0x0000FF) >> 0, alpha);
  }

  // 自定义appbar
  static AppBar getBgAppBar(String title,
      {List<Widget>? actions, Function? backCallback}) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      shadowColor: Colors.transparent,
      title: Text(
        title,
        style: TextStyle(
            fontSize: 24.sp, fontWeight: FontWeight.bold, color: Colors.black),
      ),
      leading: Padding(
          padding: EdgeInsets.only(left: 15.w),
          child: BackButton(
            color: Colors.black,
            onPressed: () {
              if (backCallback != null) {
                backCallback();
              } else {
                Get.back();
              }
            },
          )),
      actions: actions,
    );
  }
}
