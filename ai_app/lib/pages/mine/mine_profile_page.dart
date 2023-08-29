import 'package:app/contants/business_constants.dart';
import 'package:app/controller/mine_controller.dart';
import 'package:app/models/update_user_info_model.dart';
import 'package:app/utils/common_util.dart';
import 'package:app/widgets/common/common_btn.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:group_button/group_button.dart';

class MineProfilePage extends GetView<MineController> {
  MineProfilePage({super.key});

  final TextEditingController _nameEditController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String? account = controller.loginModel.value.email;
    if (controller.loginModel.value.accountTypeEnum == 'GOOGLE') {
      account = controller.loginModel.value.googleId;
    } else if (controller.loginModel.value.accountTypeEnum == 'APPLE') {
      account = controller.loginModel.value.appleId;
    }
    _nameEditController.text = controller.loginModel.value.userName ?? '';

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CommonUtil.getBgAppBar('Profile'),
      body: Stack(
        children: [
          Container(
              width: 1.sw,
              padding: EdgeInsets.only(top: 136.w),
              decoration: BoxDecoration(
                  color: CommonUtil.hexColor(0xA1A8B0).withAlpha(50)),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        ClipRRect(
                            borderRadius:
                                BorderRadius.all(Radius.circular(100.w)),
                            child: Image.asset(
                                '${BusinessConstants.imgPathPrefix}/chat/avtar1.png',
                                width: 130.w,
                                height: 130.w))
                      ],
                    )
                  ])),
          Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                height: 526.w,
                padding: EdgeInsets.fromLTRB(24.w, 16.w, 24.w, 0),
                decoration: BoxDecoration(
                    color: CommonUtil.hexColor(0xF9F9FA),
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(24.w))),
                child: Column(
                  children: [
                    Expanded(
                        child: SingleChildScrollView(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                          Text(
                            'Account',
                            style: TextStyle(
                                fontSize: 14.sp,
                                color: CommonUtil.hexColor(0xC2C9D1)),
                          ),
                          SizedBox(height: 8.w),
                          Container(
                            width: 1.sw,
                            height: 48.w,
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.only(left: 12.w),
                            decoration: BoxDecoration(
                                color: CommonUtil.hexColor(0xD1DAE5),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12.w))),
                            child: Text(account ?? ''),
                          ),
                          SizedBox(height: 24.w),
                          Text(
                            'Name',
                            style: TextStyle(
                                fontSize: 14.sp,
                                color: CommonUtil.hexColor(0xC2C9D1)),
                          ),
                          SizedBox(height: 8.w),
                          Container(
                            width: 1.sw,
                            height: 48.w,
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.only(left: 12.w),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                    color: CommonUtil.hexColor(0xA7AEB7)),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12.w))),
                            child: TextField(
                              controller: _nameEditController,
                              decoration: const InputDecoration(
                                  border: InputBorder.none),
                            ),
                          ),
                          SizedBox(height: 24.w),
                          Text(
                            'Pronouns',
                            style: TextStyle(
                                fontSize: 14.sp,
                                color: CommonUtil.hexColor(0xC2C9D1)),
                          ),
                          SizedBox(height: 8.w),
                          GroupButton(
                            controller: controller.buttonController,
                            buttons: const ['He', 'She', 'They'],
                            onSelected: (value, index, isSelected) {
                              controller.sex.value = value.toUpperCase();
                            },
                            options: GroupButtonOptions(
                                groupingType: GroupingType.row,
                                mainGroupAlignment:
                                    MainGroupAlignment.spaceAround,
                                selectedColor: Colors.white,
                                buttonWidth: 107.w,
                                buttonHeight: 48.w,
                                spacing: 0,
                                selectedTextStyle: TextStyle(
                                    fontSize: 16.sp,
                                    color: CommonUtil.hexColor(0xFF0C57)),
                                unselectedTextStyle: TextStyle(
                                    fontSize: 16.sp, color: Colors.black),
                                selectedBorderColor:
                                    CommonUtil.hexColor(0xFF0C57),
                                unselectedBorderColor:
                                    CommonUtil.hexColor(0xA7AEB7),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12.w))),
                          ),
                          SizedBox(height: 24.w),
                          Text(
                            'Birthday',
                            style: TextStyle(
                                fontSize: 14.sp,
                                color: CommonUtil.hexColor(0xC2C9D1)),
                          ),
                          SizedBox(height: 8.w),
                          GestureDetector(
                              onTap: () {
                                DatePicker.showDatePicker(
                                  context,
                                  onConfirm: (time) {
                                    controller.birthDate.value =
                                        DateUtil.formatDate(time,
                                            format: 'dd/MM/yyyy');
                                  },
                                );
                              },
                              child: Container(
                                width: 1.sw,
                                height: 48.w,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                        color: CommonUtil.hexColor(0xA7AEB7)),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(12.w))),
                                child: Obx(() => Text(
                                      controller.birthDate.value,
                                      style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w500),
                                    )),
                              )),
                        ]))),
                    CommonBtn(
                      onPressed: () {
                        if (_nameEditController.text.isEmpty ||
                            controller.sex.value.isEmpty) {
                          EasyLoading.showToast('请输入用户名或选择性别');
                          return;
                        }
                        UpdateUserInfoModel userInfoModel =
                            UpdateUserInfoModel();
                        userInfoModel.accountId =
                            controller.loginModel.value.accountId;
                        userInfoModel.birth = controller.birthDate.value;
                        userInfoModel.userName = _nameEditController.text;
                        userInfoModel.pronounsTypeEnum = controller.sex.value;

                        controller.updateUserInfo(userInfoModel,
                            succussCallback: () {
                          EasyLoading.showToast('更新成功');
                          Get.back();
                        });
                      },
                      backgroundColor: CommonUtil.hexColor(0xFF0C57),
                      text: 'Submit',
                    ),
                    SizedBox(height: 46.w)
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
