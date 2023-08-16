import 'package:app/controller/mine_controller.dart';
import 'package:app/utils/common_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MineAboutPage extends GetView<MineController> {
  MineAboutPage({super.key});

  final Map<int, String> textMap = {
    0: 'Contact us',
    1: 'Rate us',
    2: 'Private Policy',
    3: 'Term of Service'
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CommonUtil.getBgAppBar('About us'),
      body: Stack(
        children: [
          Container(
              width: 1.sw,
              decoration: BoxDecoration(
                  color: CommonUtil.hexColor(0xA1A8B0).withAlpha(50)),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 116.w),
                      width: 132.w,
                      height: 132.w,
                      decoration: BoxDecoration(
                          color: CommonUtil.hexColor(0xFF0000).withAlpha(80),
                          borderRadius:
                              BorderRadius.all(Radius.circular(12.w))),
                    ),
                    SizedBox(height: 6.w),
                    Obx(() => Text('v${controller.version.value}',
                        style: TextStyle(
                            fontSize: 16.sp, fontWeight: FontWeight.w600)))
                  ])),
          Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                height: 526.w,
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
                              onTap: () {
                                if (index == 1) {}
                              },
                              child: SizedBox(
                                  height: 64.w,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                          child: Text(textMap[index]!,
                                              style: TextStyle(
                                                  fontSize: 16.sp,
                                                  fontWeight:
                                                      FontWeight.w600))),
                                      const Icon(
                                        Icons.arrow_forward_ios_outlined,
                                      )
                                    ],
                                  )));
                        },
                        separatorBuilder: (context, index) {
                          return Divider(
                              thickness: 1.w,
                              color: Colors.black.withAlpha(25));
                        },
                        shrinkWrap: true,
                        itemCount: textMap.keys.length)),
              ))
        ],
      ),
    );
  }
}
