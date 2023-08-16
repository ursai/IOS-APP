import 'package:app/contants/business_constants.dart';
import 'package:app/contants/router_name.dart';
import 'package:app/controller/mine_controller.dart';
import 'package:app/network/network_config.dart';
import 'package:app/utils/common_util.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MineSetting extends GetView<MineController> {
  const MineSetting({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CommonUtil.getBgAppBar('Setting'),
      body: Container(
          color: CommonUtil.hexColor(0xA1A8B0).withAlpha(50),
          child: ListView.separated(
              padding: EdgeInsets.fromLTRB(24.w, 126.w, 24.w, 0),
              itemBuilder: (context, index) {
                return Row(
                  children: [
                    Expanded(
                        child: GestureDetector(
                            onTap: () async {
                              await SpUtil.remove(BusinessConstants.tokenKey);
                              NetworkConfig.headers['authorization'] = '';
                              Get.offAllNamed(RouterName.loginRouter);
                            },
                            child: Text('Log out',
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600)))),
                    const Icon(Icons.arrow_forward_ios_outlined)
                  ],
                );
              },
              separatorBuilder: (context, index) {
                return Divider(
                    thickness: 1.w, color: Colors.black.withAlpha(25));
              },
              itemCount: 1)),
    );
  }
}
