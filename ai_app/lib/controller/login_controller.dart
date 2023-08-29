import 'package:app/contants/api_path.dart';
import 'package:app/contants/business_constants.dart';
import 'package:app/models/login_model.dart';
import 'package:app/models/login_request_model.dart';
import 'package:app/network/api_client.dart';
import 'package:app/network/network_config.dart';
import 'package:app/utils/auth_repository.dart';
import 'package:countly_flutter/countly_flutter.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

enum LoginType { email, google, apple }

class LoginController extends GetxController {
  final GoogleAuthRepository _googleAuthRepository = GoogleAuthRepository();
  final AppleAuthRepository _appleAuthRepository = AppleAuthRepository();

  var isRegister = false.obs;
  LoginModel? loginModel;

  // Google授权
  void googleAuth(Function callback) async {
    String? googleUid = await _googleAuthRepository.signInWithGoogle();
    Countly.log('Google id is $googleUid', logLevel: LogLevel.INFO);
    if (googleUid != null) {
      callback(googleUid);
    }
  }

  // Apple授权
  void uriAppleAuth(Function callback) async {
    String? appleUid = await _appleAuthRepository.signInWithApple();
    Countly.log('Apple id is $appleUid', logLevel: LogLevel.INFO);
    if (appleUid != null) {
      callback(appleUid);
    }
  }

  // 登录(邮箱，Google或苹果登录)
  void login(LoginRequestModel loginRequestModel, {Function? successCallback}) {
    ApiClient().post(ApiPath.loginApi, data: loginRequestModel.toJson(),
        successCallback: (data) async {
      loginModel = LoginModel.fromJson(data);
      // 保存登录数据
      await SpUtil.putObject(
          BusinessConstants.userInfoKey, loginModel!.toJson());
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
      // 保存登录数据
      await SpUtil.putObject(BusinessConstants.userInfoKey, loginModel!);
      // 保存token
      await SpUtil.putString(
          BusinessConstants.tokenKey, loginModel?.token ?? '');
      NetworkConfig.headers['authorization'] = loginModel?.token;
      if (successCallback != null) {
        successCallback();
      }
    });
  }
}
