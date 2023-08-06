import 'package:app/controller/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

class LoginInputWidget extends GetView<LoginController> {
  LoginInputWidget(
      {super.key,
      this.icon,
      this.editingController,
      this.hintText,
      this.obscureText,
      this.textInputType});

  final TextEditingController? editingController;

  final Image? icon;
  final String? hintText;
  final TextInputType? textInputType;
  final bool? obscureText;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.w,
      padding: EdgeInsets.symmetric(horizontal: 30.w),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(24.w))),
      child: Row(
        children: [
          icon ?? const SizedBox.shrink(),
          SizedBox(width: 12.5.w),
          Expanded(
              child: TextField(
                  controller: editingController,
                  keyboardType: textInputType,
                  obscureText: obscureText ?? false,
                  decoration: InputDecoration(
                      border: InputBorder.none, hintText: hintText),
                  style: TextStyle(fontSize: 16.w)))
        ],
      ),
    );
  }
}
