import 'package:app/contants/business_constants.dart';
import 'package:app/contants/router_name.dart';
import 'package:app/controller/discovery_controller.dart';
import 'package:app/models/discovery_model.dart';
import 'package:app/utils/common_util.dart';
import 'package:app/widgets/common/app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class DiscoveryPage extends StatefulWidget {
  const DiscoveryPage({super.key});

  @override
  _DiscoveryPageState createState() => _DiscoveryPageState();
}

class _DiscoveryPageState extends State<DiscoveryPage>
    with AutomaticKeepAliveClientMixin {
  late DisCoveryController controller;

  @override
  void initState() {
    super.initState();

    controller = Get.find();
    controller.queryDiscoveryList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1.sh,
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                  '${BusinessConstants.imgPathPrefix}/discovery/discover_bg.png'),
              fit: BoxFit.fill)),
      padding: EdgeInsets.fromLTRB(
          24.w, 16.w + ScreenUtil().statusBarHeight, 24.w, 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Discovery',
            style: TextStyle(fontSize: 32.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 24.w),
          Expanded(
              child: Obx(() => MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  child: ListView.separated(
                      itemBuilder: ((context, index) {
                        Records record = controller.discoverList[index];
                        return GestureDetector(
                            onTap: () {
                              Get.toNamed(RouterName.profileRouter,
                                  arguments: record);
                            },
                            child: _buildItem(record));
                      }),
                      separatorBuilder: (context, index) {
                        return SizedBox(height: 16.w);
                      },
                      shrinkWrap: true,
                      itemCount: controller.discoverList.length))))
        ],
      ),
    );
  }

  Widget _buildItem(Records record) {
    return Container(
      height: 130.w,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(8.w))),
      child: Row(
        children: [
          AppImage.asset(
              '${BusinessConstants.imgPathPrefix}/default_avtar.png'),
          Expanded(
              child: Container(
            padding: EdgeInsets.fromLTRB(12.w, 16.w, 16.w, 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  Text('${record.name}',
                      style: TextStyle(
                          fontSize: 16.sp, fontWeight: FontWeight.w600)),
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
                SizedBox(height: 8.w),
                Text(
                  record.topic!.isNotEmpty ? '${record.topic?[0]}' : '',
                  softWrap: true,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 12.w),
                )
              ],
            ),
          )),
        ],
      ),
    );
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

  @override
  bool get wantKeepAlive => true;
}
