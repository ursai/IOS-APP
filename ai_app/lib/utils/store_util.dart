import 'dart:io';

import 'package:app/contants/business_constants.dart';
import 'package:flustars/flustars.dart';
import 'package:path_provider/path_provider.dart';

class StoreUtil {
  static String currentVersion = '1.0.0';

  static bool isLogin() {
    return !ObjectUtil.isEmptyString(
        SpUtil.getString(BusinessConstants.tokenKey));
  }
}
