import 'package:app/controller/mine_controller.dart';
import 'package:app/models/update_user_info_model.dart';
import 'package:app/utils/common_util.dart';
import 'package:app/widgets/common/common_btn.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MineBirthPage extends GetView<MineController> {
  const MineBirthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CommonUtil.getBgAppBar('Your birth'),
      body: SingleChildScrollView(
          child: Container(
        height: 1.sh,
        color: CommonUtil.hexColor(0xA1A8B0).withAlpha(50),
        padding: EdgeInsets.fromLTRB(24.w, 126.w, 24.w, 0),
        child: Column(
          children: [
            Expanded(
                child: Column(
              children: [
                GestureDetector(
                    onTap: () {
                      DatePicker.showDatePicker(
                        context,
                        onConfirm: (time) {
                          controller.birthDate.value =
                              DateUtil.formatDate(time, format: 'dd/MM/yyyy');
                        },
                      );
                    },
                    child: Container(
                      width: 1.sw,
                      height: 48.w,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border:
                              Border.all(color: CommonUtil.hexColor(0xA7AEB7)),
                          borderRadius:
                              BorderRadius.all(Radius.circular(12.w))),
                      child: Obx(() => Text(
                            controller.birthDate.value,
                            style: TextStyle(
                                fontSize: 16.sp, fontWeight: FontWeight.w500),
                          )),
                    ))
              ],
            )),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CommonBtn(
                    onPressed: () {
                      UpdateUserInfoModel userInfoModel = UpdateUserInfoModel();
                      userInfoModel.accountId =
                          controller.loginModel.value.accountId;
                      userInfoModel.birth = controller.birthDate.value;
                      userInfoModel.pronounsTypeEnum = controller.sex.value;
                      userInfoModel.userName = controller.userName;
                      controller.updateUserInfo(userInfoModel,
                          succussCallback: () {
                        Get.offAllNamed('/');
                      });
                    },
                    text: 'Continue',
                    size: Size(128.w, 58.w),
                    backgroundColor: CommonUtil.hexColor(0xFF0C57))
              ],
            ),
            SizedBox(height: 82.w)
          ],
        ),
      )),
    );
  }
}
