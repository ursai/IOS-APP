import 'package:app/contants/business_constants.dart';
import 'package:app/contants/router_name.dart';
import 'package:app/controller/mine_controller.dart';
import 'package:app/utils/common_util.dart';
import 'package:app/widgets/common/app_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

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
                  SizedBox(
                    width: 129.w,
                    height: 129.w,
                    child: Stack(
                      children: [
                        ClipRRect(
                            borderRadius:
                                BorderRadius.all(Radius.circular(100.w)),
                            child: Obx(() => AppImage.netWork(
                                controller.headerUrl.value,
                                width: 130.w,
                                height: 130.w))),
                        Align(
                            alignment: Alignment.bottomRight,
                            child: GestureDetector(
                                onTap: () {
                                  final ImagePicker picker = ImagePicker();
                                  showCupertinoModalPopup<void>(
                                      context: context,
                                      builder: ((context) =>
                                          CupertinoActionSheet(
                                            actions: [
                                              CupertinoActionSheetAction(
                                                  onPressed: () async {
                                                    final XFile? image =
                                                        await picker.pickImage(
                                                            source: ImageSource
                                                                .gallery);
                                                    if (image != null) {
                                                      Get.back();
                                                      controller
                                                          .uploadHeaderPic(
                                                              image);
                                                    }
                                                  },
                                                  child: const Text('Gallery')),
                                              CupertinoActionSheetAction(
                                                  onPressed: () async {
                                                    final XFile? image =
                                                        await picker.pickImage(
                                                            source: ImageSource
                                                                .camera);
                                                    if (image != null) {
                                                      Get.back();
                                                      controller
                                                          .uploadHeaderPic(
                                                              image);
                                                    }
                                                  },
                                                  child: const Text('Camera')),
                                              CupertinoActionSheetAction(
                                                  onPressed: () {
                                                    Get.back();
                                                  },
                                                  child: const Text('Cancel')),
                                            ],
                                          )));
                                },
                                child: Container(
                                  width: 50.w,
                                  height: 50.w,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(12.w))),
                                  child: const Icon(Icons.camera_alt_rounded),
                                )))
                      ],
                    ),
                  ),
                  SizedBox(height: 10.w),
                  Obx(() => Text(controller.loginModel.value.userName ?? '',
                      style: TextStyle(
                          fontSize: 20.sp, fontWeight: FontWeight.w600))),
                  Text('UID: ${controller.loginModel.value.accountId ?? -1}',
                      style: TextStyle(
                          fontSize: 14.sp, fontWeight: FontWeight.w400))
                ])),
        Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              height: 1.sh,
              margin: EdgeInsets.only(top: 349.w),
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
