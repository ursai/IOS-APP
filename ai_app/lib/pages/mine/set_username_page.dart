import 'package:app/contants/business_constants.dart';
import 'package:app/controller/chat_controller.dart';
import 'package:app/controller/discovery_controller.dart';
import 'package:app/controller/login_controller.dart';
import 'package:app/controller/mine_controller.dart';
import 'package:app/models/user_info_model.dart';
import 'package:app/utils/common_util.dart';
import 'package:app/widgets/common/common_btn.dart';
import 'package:app/widgets/mine/login_input_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SetUserNamePage extends GetView<LoginController> {
  SetUserNamePage({super.key});

  final TextEditingController _usernameTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CommonUtil.getBgAppBar('Your name'),
      body: SingleChildScrollView(
          child: Container(
        height: 1.sh,
        color: CommonUtil.hexColor(0xA1A8B0).withAlpha(50),
        padding: EdgeInsets.fromLTRB(24.w, 126.w, 24.w, 0),
        child: Column(
          children: [
            LoginInputWidget(
              editingController: _usernameTextController,
              icon: Image.asset(
                  '${BusinessConstants.imgPathPrefix}/mine/login_user.png',
                  width: 24.w,
                  height: 24.w),
              hintText: 'Enter your name',
            ),
            SizedBox(height: 247.w),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CommonBtn(
                    onPressed: () {
                      if (_usernameTextController.text.isEmpty) {
                        EasyLoading.showToast('user name cannot empty');
                        return;
                      }
                      UserInfoModel model =
                          UserInfoModel(userName: _usernameTextController.text);
                      model.accountId = controller.loginModel?.accountId;
                      controller.updateUserInfo(model, successCallback: () {
                        Get.put(DisCoveryController());
                        Get.put(MineController());
                        Get.put(ChatController());
                        Get.offAllNamed('/');
                      });
                    },
                    text: 'Continue',
                    size: Size(128.w, 58.w),
                    backgroundColor: CommonUtil.hexColor(0xFF0C57))
              ],
            )
          ],
        ),
      )),
    );
  }
}
