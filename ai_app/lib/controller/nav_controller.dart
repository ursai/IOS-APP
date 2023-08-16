import 'package:app/contants/api_path.dart';
import 'package:app/controller/mine_controller.dart';
import 'package:app/network/api_client.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavController extends GetxController {
  final PageController pageController = PageController();
  var tabIndex = 0.obs;

  // 上传推送token
  void updatePushToken(String token, {Function? successCallback}) {
    MineController mineController = Get.find();
    int? accountId = mineController.loginModel.value.accountId;
    if (accountId != null) {
      ApiClient().post(ApiPath.pushTokenApi,
          isShowLoading: false, data: {'accountId': accountId, 'token': token},
          successCallback: (data) {
        if (successCallback != null) {
          successCallback();
        }
      });
    }
  }
}
