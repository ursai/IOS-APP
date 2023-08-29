import 'package:app/contants/api_path.dart';
import 'package:app/contants/business_constants.dart';
import 'package:app/models/login_model.dart';
import 'package:app/models/update_user_info_model.dart';
import 'package:app/network/api_client.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:group_button/group_button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:package_info_plus/package_info_plus.dart';

class MineController extends GetxController {
  var version = '1.0.0'.obs;
  // 选择的生日
  var birthDate = ''.obs;
  // 性别
  var sex = ''.obs;
  final sexMap = {0: 'She', 1: 'He', 2: 'They'};
  // 名称
  String userName = '';
  // 头像url
  var headerUrl = ''.obs;

  var selectSexIndex = 1.obs;

  late GroupButtonController buttonController;

  var loginModel = LoginModel().obs;

  @override
  void onInit() async {
    super.onInit();

    await SpUtil.getInstance();
    loginModel.value = SpUtil.getObj<LoginModel>(
            BusinessConstants.userInfoKey, (v) => LoginModel.fromJson(v)) ??
        LoginModel();
    birthDate.value = loginModel.value.birth ??
        DateUtil.formatDate(DateTime.now(), format: 'dd/MM/yyyy');
    int selectIndex = 0;
    if (loginModel.value.pronounsTypeEnum == 'SHE') {
      selectIndex = 1;
    } else if (loginModel.value.pronounsTypeEnum == 'THEY') {
      selectIndex = 2;
    }
    buttonController = GroupButtonController(selectedIndex: selectIndex);
    sex.value = sexMap[selectIndex]!.toUpperCase();

    currentVersion();
  }

  // 获取版本号
  void currentVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    version.value = packageInfo.version;
  }

  // 更新用户信息
  void updateUserInfo(UpdateUserInfoModel userInfoModel,
      {Function? succussCallback}) {
    ApiClient().post(ApiPath.updateUserInfoApi, data: userInfoModel.toJson(),
        successCallback: (data) {
      loginModel.value.birth = userInfoModel.birth;
      loginModel.value.pronounsTypeEnum = userInfoModel.pronounsTypeEnum;
      loginModel.value.userName = userInfoModel.userName;
      loginModel.refresh();
      if (succussCallback != null) {
        succussCallback();
      }
    });
  }

  // 上传头像
  void uploadHeaderPic(XFile image) async {
    var attfile =
        await dio.MultipartFile.fromFile(image.path, filename: image.name);
    dio.FormData formData = dio.FormData.fromMap({'multipartFile': attfile});
    ApiClient().upload(ApiPath.uploadHeaderPicApi, data: formData,
        successCallback: (data) {
      headerUrl.value = data;
    });
  }

  // 登出
  void logout({Function? successCallback}) {
    ApiClient().upload(ApiPath.logoutApi, successCallback: (data) {
      if (successCallback != null) {
        successCallback();
      }
    });
  }

  // 删除账号
  void delAccount({Function? successCallback}) {
    ApiClient().upload(ApiPath.delAccountApi, successCallback: (data) {
      if (successCallback != null) {
        successCallback();
      }
    });
  }
}
