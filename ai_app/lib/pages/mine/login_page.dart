import 'package:app/contants/business_constants.dart';
import 'package:app/controller/login_controller.dart';
import 'package:app/models/login_request_model.dart';
import 'package:app/utils/common_util.dart';
import 'package:app/widgets/common/common_btn.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: CommonUtil.hexColor(0xA1A8B0),
      padding: EdgeInsets.fromLTRB(
          24.w, 126.w, 24.w, 48.w + ScreenUtil().bottomBarHeight),
      child: Column(
        children: [
          Text(
            'Welcome to  the community',
            style: TextStyle(fontSize: 42.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 290.w),
          CommonBtn(
              backgroundColor: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                      '${BusinessConstants.imgPathPrefix}/mine/apple_login.png',
                      width: 24.w,
                      height: 24.w),
                  Text(
                    'Continue with Apple',
                    style: TextStyle(fontSize: 14.sp, color: Colors.black),
                  )
                ],
              ),
              onPressed: () {
                controller.uriAppleAuth((email) {
                  LoginRequestModel loginRequestModel = LoginRequestModel();
                  loginRequestModel.accountTypeEnum = 'APPLE';
                  loginRequestModel.appleId = email;
                  controller.login(loginRequestModel);
                });
              }),
          SizedBox(height: 12.w),
          CommonBtn(
              backgroundColor: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                      '${BusinessConstants.imgPathPrefix}/mine/google_login.png',
                      width: 24.w,
                      height: 24.w),
                  Text(
                    'Continue with Google',
                    style: TextStyle(fontSize: 14.sp, color: Colors.black),
                  )
                ],
              ),
              onPressed: () {
                controller.googleAuth((token) {
                  LoginRequestModel loginRequestModel = LoginRequestModel();
                  loginRequestModel.accountTypeEnum = 'GOOGLE';
                  loginRequestModel.googleId = token;
                  controller.login(loginRequestModel);
                });
              }),
          SizedBox(height: 12.w),
          CommonBtn(
              onPressed: () {},
              text: 'Continue with Account',
              textStyle: TextStyle(fontSize: 14.sp, color: Colors.black),
              backgroundColor: Colors.white),
          SizedBox(height: 12.w),
          Text.rich(
            TextSpan(
              text: 'By sign up,  you’re agreeing to our ',
              style: TextStyle(fontSize: 12.sp),
              children: [
                TextSpan(
                    text: 'Terms & Conditions',
                    style: TextStyle(
                        fontSize: 12.sp, color: CommonUtil.hexColor(0xFF0C57)),
                    recognizer: TapGestureRecognizer()..onTap = () {}),
                TextSpan(
                  text: ' and ',
                  style: TextStyle(fontSize: 12.sp),
                ),
                TextSpan(
                    text: 'Privacy Policy',
                    style: TextStyle(
                        fontSize: 12.sp, color: CommonUtil.hexColor(0xFF0C57)),
                    recognizer: TapGestureRecognizer()..onTap = () {}),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
