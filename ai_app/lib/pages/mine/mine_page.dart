import 'package:app/contants/business_constants.dart';
import 'package:app/controller/mine_controller.dart';
import 'package:app/utils/common_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MinePage extends GetView<MineController> {
  const MinePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 1.sh,
        decoration: BoxDecoration(color: CommonUtil.hexColor(0xA1A8B0)),
        padding: EdgeInsets.fromLTRB(0, 58.w, 0, 16.w),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
              padding: EdgeInsets.only(left: 26.w),
              child: Text(
                'Profile',
                style: TextStyle(fontSize: 32.sp, fontWeight: FontWeight.bold),
              )),
          SizedBox(height: 24.w),
        ]));
  }
}
