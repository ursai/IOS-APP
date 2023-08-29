import 'package:app/contants/business_constants.dart';
import 'package:app/contants/router_name.dart';
import 'package:app/controller/mine_controller.dart';
import 'package:app/network/network_config.dart';
import 'package:app/utils/common_util.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
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
                return SizedBox(
                    height: 60.w,
                    child: Row(
                      children: [
                        Expanded(
                            child: GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: () async {
                                  if (index == 0) {
                                    controller.logout(
                                        successCallback: () async {
                                      await SpUtil.remove(
                                          BusinessConstants.tokenKey);
                                      NetworkConfig.headers['authorization'] =
                                          '';
                                      Get.offAllNamed(RouterName.loginRouter);
                                    });
                                  } else if (index == 1) {
                                    controller.delAccount(
                                        successCallback: () async {
                                      EasyLoading.showToast('删除成功');
                                      await SpUtil.remove(
                                          BusinessConstants.tokenKey);
                                      NetworkConfig.headers['authorization'] =
                                          '';
                                      Get.offAllNamed(RouterName.loginRouter);
                                    });
                                  }
                                },
                                child: Text(
                                    index == 0 ? 'Log out' : 'Delete Account',
                                    style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600)))),
                        const Icon(Icons.arrow_forward_ios_outlined)
                      ],
                    ));
              },
              separatorBuilder: (context, index) {
                return Divider(
                    thickness: 1.w, color: Colors.black.withAlpha(25));
              },
              itemCount: 2)),
    );
  }
}
