import 'package:app/contants/business_constants.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';

class CommonUtil {
  static bool isLogin() {
    return !ObjectUtil.isEmptyString(
        SpUtil.getString(BusinessConstants.tokenKey));
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
}
