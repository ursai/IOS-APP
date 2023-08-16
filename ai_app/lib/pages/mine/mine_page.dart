import 'package:app/contants/business_constants.dart';
import 'package:app/contants/router_name.dart';
import 'package:app/controller/mine_controller.dart';
import 'package:app/utils/common_util.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MinePage extends GetView<MineController> {
  MinePage({super.key});

  final Map<int, String> iconPathMap = {
    0: '${BusinessConstants.imgPathPrefix}/mine/mine_profile.png',
    1: '${BusinessConstants.imgPathPrefix}/mine/mine_setting.png',
    2: '${BusinessConstants.imgPathPrefix}/mine/mine_about.png'
  };
  final Map<int, String> textMap = {0: 'Profile', 1: 'Settings', 2: 'About us'};

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
            width: 1.sw,
            decoration: BoxDecoration(
                color: CommonUtil.hexColor(0xA1A8B0).withAlpha(50)),
            padding: EdgeInsets.fromLTRB(0, 58.w, 0, 16.w),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Expanded(
                          child: Padding(
                              padding: EdgeInsets.only(left: 26.w),
                              child: Text(
                                'Profile',
                                style: TextStyle(
                                    fontSize: 32.sp,
                                    fontWeight: FontWeight.bold),
                              )))
                    ],
                  ),
                  SizedBox(height: 24.w),
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
                  ),
                  SizedBox(height: 10.w),
                  Text(controller.loginModel.value.userName ?? '',
                      style: TextStyle(
                          fontSize: 20.sp, fontWeight: FontWeight.w600)),
                  Text('UID: ${controller.loginModel.value.accountId ?? -1}',
                      style: TextStyle(
                          fontSize: 14.sp, fontWeight: FontWeight.w400))
                ])),
        Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              height: 400.w,
              padding: EdgeInsets.fromLTRB(24.w, 16.w, 24.w, 0),
              decoration: BoxDecoration(
                  color: CommonUtil.hexColor(0xF9F9FA),
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(24.w))),
              child: MediaQuery.removePadding(
                  removeTop: true,
                  context: context,
                  child: ListView.separated(
                      itemBuilder: (context, index) {
                        return GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () {
                              switch (index) {
                                case 0:
                                  Get.toNamed(RouterName.mineProfileRouter);
                                  break;
                                case 1:
                                  Get.toNamed(RouterName.minSettingPageRouter);
                                  break;
                                case 2:
                                  Get.toNamed(RouterName.mineAboutRouter);
                                  break;
                              }
                            },
                            child: SizedBox(
                                height: 64.w,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(iconPathMap[index]!,
                                        width: 32.w, height: 32.w),
                                    SizedBox(width: 12.w),
                                    Expanded(
                                        child: Text(textMap[index]!,
                                            style: TextStyle(
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.w600))),
                                    const Icon(
                                      Icons.arrow_forward_ios_outlined,
                                    )
                                  ],
                                )));
                      },
                      separatorBuilder: (context, index) {
                        return Divider(
                            thickness: 1.w, color: Colors.black.withAlpha(25));
                      },
                      shrinkWrap: true,
                      itemCount: textMap.keys.length)),
            ))
      ],
    );
  }
}
