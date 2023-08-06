import 'package:app/contants/api_path.dart';
import 'package:app/contants/business_constants.dart';
import 'package:app/models/login_model.dart';
import 'package:app/models/login_request_model.dart';
import 'package:app/network/api_client.dart';
import 'package:app/network/network_config.dart';
import 'package:app/utils/auth_repository.dart';
import 'package:flustars/flustars.dart';
import 'package:get/get.dart';
import 'package:app/models/user_info_model.dart';

enum LoginType { email, google, apple }

class LoginController extends GetxController {
  final GoogleAuthRepository _googleAuthRepository = GoogleAuthRepository();
  final AppleAuthRepository _appleAuthRepository = AppleAuthRepository();

  var isRegister = false.obs;
  LoginModel? loginModel;

  // Google授权
  void googleAuth(Function callback) async {
    String? email = await _googleAuthRepository.signInWithGoogle();
    if (email != null) {
      callback(email);
    }
  }

  // Apple授权
  void uriAppleAuth(Function callback) async {
    String? email = await _appleAuthRepository.signInWithApple();
    if (email != null) {
      callback(email);
    }
  }

  // 登录(邮箱，Google或苹果登录)
  void login(LoginRequestModel loginRequestModel, {Function? successCallback}) {
    ApiClient().post(ApiPath.loginApi, data: loginRequestModel.toJson(),
        successCallback: (data) async {
      loginModel = LoginModel.fromJson(data);
      // 保存accountId
      await SpUtil.putInt(
          BusinessConstants.accountIdKey, loginModel?.accountId ?? -1);
      // 保存token
      await SpUtil.putString(
          BusinessConstants.tokenKey, loginModel?.token ?? '');
      NetworkConfig.headers['authorization'] = loginModel?.token;
      if (successCallback != null) {
        successCallback();
      }
    });
  }

  // 注册
  void signUp(String username, String pwd, {Function? successCallback}) {
    ApiClient()
        .post(ApiPath.registerApi, data: {'email': username, 'password': pwd},
            successCallback: (data) async {
      loginModel = LoginModel.fromJson(data);
      // 保存token
      await SpUtil.putString(
          BusinessConstants.tokenKey, loginModel?.token ?? '');
      NetworkConfig.headers['authorization'] = loginModel?.token;
      if (successCallback != null) {
        successCallback();
      }
    });
  }

  // 更新用户信息
  void updateUserInfo(UserInfoModel userInfo, {Function? successCallback}) {
    ApiClient().post(ApiPath.updateUserInfoApi, data: userInfo.toJson(),
        successCallback: (data) {
      if (successCallback != null) {
        successCallback();
      }
    });
  }
}
