import 'package:app/contants/business_constants.dart';
import 'package:app/contants/router_name.dart';
import 'package:app/controller/login_controller.dart';
import 'package:app/models/login_request_model.dart';
import 'package:app/utils/common_util.dart';
import 'package:app/utils/store_util.dart';
import 'package:app/widgets/common/common_btn.dart';
import 'package:app/widgets/mine/login_input_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LoginRegisterPage extends GetView<LoginController> {
  LoginRegisterPage({super.key});

  final TextEditingController _usernameTextController = TextEditingController();
  final TextEditingController _pwdTextController = TextEditingController();
  final TextEditingController _repwdTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CommonUtil.getBgAppBar('Log in'),
      body: SingleChildScrollView(
          child: Container(
        height: 1.sh,
        padding: EdgeInsets.fromLTRB(24.w, 126.w, 24.w, 0),
        color: CommonUtil.hexColor(0xA1A8B0).withAlpha(50),
        child: Column(
          children: [
            LoginInputWidget(
              editingController: _usernameTextController,
              hintText: 'Email',
              icon: Image.asset(
                  '${BusinessConstants.imgPathPrefix}/mine/login_email.png',
                  width: 24.w,
                  height: 24.w),
            ),
            SizedBox(height: 32.w),
            LoginInputWidget(
              hintText: 'Password',
              obscureText: true,
              editingController: _pwdTextController,
              icon: Image.asset(
                  '${BusinessConstants.imgPathPrefix}/mine/login_password.png',
                  width: 24.w,
                  height: 24.w),
            ),
            SizedBox(height: 32.w),
            Obx(() {
              if (controller.isRegister.value) {
                return LoginInputWidget(
                  hintText: 'Repeat Password',
                  obscureText: true,
                  editingController: _repwdTextController,
                  icon: Image.asset(
                      '${BusinessConstants.imgPathPrefix}/mine/login_password.png',
                      width: 24.w,
                      height: 24.w),
                );
              } else {
                return const SizedBox.shrink();
              }
            }),
            Obx(() =>
                SizedBox(height: controller.isRegister.value ? 48.w : 82.w)),
            Obx(() => CommonBtn(
                onPressed: () {
                  if (_usernameTextController.text.isEmpty ||
                      _pwdTextController.text.isEmpty) {
                    EasyLoading.showToast('用户名或密码不能为空');
                    return;
                  }
                  if (controller.isRegister.value &&
                      _repwdTextController.text.isEmpty) {
                    EasyLoading.showToast('用户名或密码不能为空');
                    return;
                  }
                  // 注册
                  if (controller.isRegister.value) {
                    controller.signUp(
                        _usernameTextController.text, _pwdTextController.text,
                        successCallback: () {
                      Get.toNamed(RouterName.usernameRouter);
                    });
                  } else {
                    // 登录
                    LoginRequestModel model = LoginRequestModel();
                    model.accountTypeEnum = 'EMAIL';
                    model.email = _usernameTextController.text;
                    model.password = _pwdTextController.text;
                    controller.login(model, successCallback: () {
                      Get.toNamed(RouterName.usernameRouter);
                    });
                  }
                },
                text: controller.isRegister.value ? 'Sign up' : 'Log in',
                backgroundColor: CommonUtil.hexColor(0xFF0C57))),
            SizedBox(height: 20.w),
            Obx(() => TextButton(
                onPressed: () {
                  controller.isRegister.value = !controller.isRegister.value;
                },
                child: Text(
                  controller.isRegister.value ? 'Log in' : 'Sign up',
                  style: TextStyle(fontSize: 14.sp, color: Colors.black),
                ))),
            SizedBox(height: 29.w),
            Obx(() {
              if (controller.isRegister.value) {
                return Text.rich(
                  TextSpan(
                    text: 'By sign up,  you’re agreeing to our ',
                    style: TextStyle(fontSize: 12.sp),
                    children: [
                      TextSpan(
                          text: 'Terms & Conditions',
                          style: TextStyle(
                              fontSize: 12.sp,
                              color: CommonUtil.hexColor(0xFF0C57)),
                          recognizer: TapGestureRecognizer()..onTap = () {}),
                      TextSpan(
                        text: ' and ',
                        style: TextStyle(fontSize: 12.sp),
                      ),
                      TextSpan(
                          text: 'Privacy Policy',
                          style: TextStyle(
                              fontSize: 12.sp,
                              color: CommonUtil.hexColor(0xFF0C57)),
                          recognizer: TapGestureRecognizer()..onTap = () {}),
                    ],
                  ),
                  textAlign: TextAlign.center,
                );
              } else {
                return const SizedBox.shrink();
              }
            })
          ],
        ),
      )),
    );
  }
}
