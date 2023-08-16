import 'package:app/contants/business_constants.dart';
import 'package:app/models/login_model.dart';
import 'package:flustars/flustars.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

class MineController extends GetxController {
  var version = '1.0.0'.obs;
  // 选择的生日
  var birthDate = ''.obs;
  var loginModel = LoginModel().obs;

  @override
  void onInit() {
    super.onInit();

    loginModel.value = SpUtil.getObj<LoginModel>(
            BusinessConstants.userInfoKey, (v) => LoginModel.fromJson(v)) ??
        LoginModel();
    currentVersion();
  }

  // 获取版本号
  void currentVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    version.value = packageInfo.version;
  }
}
