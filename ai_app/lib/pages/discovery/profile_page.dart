import 'package:app/contants/business_constants.dart';
import 'package:app/contants/router_name.dart';
import 'package:app/controller/discovery_controller.dart';
import 'package:app/models/discovery_model.dart';
import 'package:app/utils/common_util.dart';
import 'package:app/widgets/common/app_image.dart';
import 'package:app/widgets/common/common_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ProfilePage extends GetView<DisCoveryController> {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    Records record = Records();
    record = Get.arguments;

    return Stack(
      children: [
        AppImage.asset(
            '${BusinessConstants.imgPathPrefix}/discovery/profile_default_avtar.png',
            width: 1.sw,
            height: 420.w),
        GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Container(
              margin: EdgeInsets.fromLTRB(24.w, 62.w, 0, 0),
              width: 50.w,
              height: 50.w,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(16.w))),
              child: Icon(
                Icons.arrow_back_ios_new,
                size: 18.w,
              ),
            )),
        Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              height: 525.w,
              padding: EdgeInsets.fromLTRB(
                  24.w, 24.w, 24.w, 12.w + ScreenUtil().bottomBarHeight),
              decoration: BoxDecoration(
                  color: CommonUtil.hexColor(0xF6F6F7),
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(16.w))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                      height: 400.w,
                      child: MediaQuery.removePadding(
                          context: context,
                          removeTop: true,
                          child: ListView(
                            shrinkWrap: true,
                            children: [
                              Row(children: [
                                Text('${record.name}',
                                    style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600)),
                                SizedBox(width: 6.w),
                                AppImage.asset(
                                    record.pronouns == 'SHE'
                                        ? '${BusinessConstants.imgPathPrefix}/discovery/female.png'
                                        : '${BusinessConstants.imgPathPrefix}/discovery/male.png',
                                    width: 16.w,
                                    height: 16.w)
                              ]),
                              SizedBox(height: 6.w),
                              _buildTagWidget(record),
                              SizedBox(height: 24.w),
                              Text(
                                'About me',
                                style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(height: 8.w),
                              Container(
                                width: 1.sw,
                                height: 75.w,
                                padding: EdgeInsets.all(12.w),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(12.w))),
                                child: Text(
                                  '${record.about}',
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontSize: 12.w),
                                ),
                              ),
                              SizedBox(height: 24.w),
                              Text(
                                'Topic',
                                style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(height: 8.w),
                              _buildTopicWidget(context, record),
                            ],
                          ))),
                  CommonBtn(
                    onPressed: () {
                      Get.toNamed(RouterName.chatPageRouter, arguments: record);
                    },
                    backgroundColor: CommonUtil.hexColor(0xFF0C57),
                    text: 'Say Hi',
                  )
                ],
              ),
            ))
      ],
    );
  }

  // topic列表
  Widget _buildTopicWidget(BuildContext context, Records record) {
    return MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: ListView.separated(
            itemBuilder: ((context, index) {
              String topic = record.topic?[index] ?? '';
              if (topic.isNotEmpty) {
                return GestureDetector(
                    onTap: () {
                      controller.selectedTopicMap[record.characterId ?? -1] =
                          topic;
                      Get.toNamed(RouterName.chatPageRouter, arguments: record);
                    },
                    child: Container(
                      width: 1.sw,
                      padding: EdgeInsets.all(12.w),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.all(Radius.circular(12.w))),
                      child: Text(
                        topic,
                        softWrap: true,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 12.w),
                      ),
                    ));
              } else {
                return const SizedBox.shrink();
              }
            }),
            separatorBuilder: (context, index) {
              return SizedBox(height: 16.w);
            },
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: record.topic?.length ?? 0));
  }

  // 标签列表widget
  Widget _buildTagWidget(Records record) {
    List<Widget> tagListWidget = [];
    int len = record.tags?.length ?? 0;
    for (int i = 0; i < len; i++) {
      String tag = record.tags![i];
      if (tag.isNotEmpty) {
        tagListWidget.add(Container(
          padding: EdgeInsets.symmetric(horizontal: 2.w),
          height: 19.w,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              border: Border.all(color: CommonUtil.hexColor(0xFF0C57)),
              borderRadius: BorderRadius.all(Radius.circular(4.w))),
          child: Text(
            tag,
            style: TextStyle(
                fontSize: 10.sp, color: CommonUtil.hexColor(0xFF0C57)),
          ),
        ));
        if (i < len - 1) {
          tagListWidget.add(SizedBox(width: 8.w));
        }
      }
    }

    return Row(children: tagListWidget);
  }
}
