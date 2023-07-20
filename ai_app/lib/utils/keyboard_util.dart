import 'package:flutter/cupertino.dart';

//软键盘相关工具类
class KeyboardUtils {
  ///隐藏软键盘
  static hideKeyboard(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }
}
