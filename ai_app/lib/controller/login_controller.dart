import 'package:app/contants/api_path.dart';
import 'package:app/models/login_request_model.dart';
import 'package:app/network/api_client.dart';
import 'package:app/utils/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum LoginType { email, google, apple }

class LoginController extends GetxController {
  final GoogleAuthRepository _googleAuthRepository = GoogleAuthRepository();
  final AppleAuthRepository _appleAuthRepository = AppleAuthRepository();
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
        successCallback: (data) {
      debugPrint(data.toString());
    });
  }

  // 注册
  void signUp() {}
}
