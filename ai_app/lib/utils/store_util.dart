import 'package:app/contants/business_constants.dart';
import 'package:flustars/flustars.dart';

class StoreUtil {
  static String currentVersion = '1.0.0';

  static bool isLogin() {
    return !ObjectUtil.isEmptyString(
        SpUtil.getString(BusinessConstants.tokenKey));
  }
}
