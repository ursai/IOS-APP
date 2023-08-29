import 'package:app/contants/router_name.dart';
import 'package:app/controller/mine_controller.dart';
import 'package:app/utils/common_util.dart';
import 'package:app/widgets/common/common_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MineSexPage extends GetView<MineController> {
  const MineSexPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CommonUtil.getBgAppBar('Your pronouns'),
      body: SingleChildScrollView(
          child: Container(
        height: 1.sh,
        color: CommonUtil.hexColor(0xA1A8B0).withAlpha(50),
        padding: EdgeInsets.fromLTRB(24.w, 126.w, 24.w, 0),
        child: Column(
          children: [
            Expanded(
                child: MediaQuery.removePadding(
                    removeTop: true,
                    context: context,
                    child: ListView.separated(
                        itemBuilder: ((context, index) {
                          return Obx(() => GestureDetector(
                              onTap: () {
                                controller.selectSexIndex.value = index;
                                controller.sex.value =
                                    controller.sexMap[index]?.toUpperCase() ??
                                        '';
                              },
                              child: Container(
                                height: 60.w,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: controller.selectSexIndex.value ==
                                            index
                                        ? Border.all(
                                            color:
                                                CommonUtil.hexColor(0xFF0C57))
                                        : null,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(24.w))),
                                child: Text(controller.sexMap[index] ?? '',
                                    style: TextStyle(
                                        fontSize: 16.sp,
                                        color: controller
                                                    .selectSexIndex.value ==
                                                index
                                            ? CommonUtil.hexColor(0xFF0C57)
                                            : CommonUtil.hexColor(0xC2C9D1))),
                              )));
                        }),
                        separatorBuilder: ((context, index) {
                          return SizedBox(height: 32.w);
                        }),
                        itemCount: 3,
                        shrinkWrap: true))),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CommonBtn(
                    onPressed: () {
                      Get.toNamed(RouterName.mineBirthRouter);
                    },
                    text: 'Continue',
                    size: Size(128.w, 58.w),
                    backgroundColor: CommonUtil.hexColor(0xFF0C57))
              ],
            ),
            SizedBox(height: 82.w),
          ],
        ),
      )),
    );
  }
}
