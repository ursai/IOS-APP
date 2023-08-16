import 'package:app/contants/business_constants.dart';
import 'package:app/contants/router_name.dart';
import 'package:app/controller/chat_controller.dart';
import 'package:app/controller/discovery_controller.dart';
import 'package:app/controller/nav_controller.dart';
import 'package:app/models/chat_model.dart';
import 'package:app/models/discovery_model.dart';
import 'package:app/utils/common_util.dart';
import 'package:app/widgets/common/app_image.dart';
import 'package:flustars/flustars.dart' as flustars;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ChatListPage extends StatefulWidget {
  const ChatListPage({super.key});

  @override
  _ChatListPageState createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage>
    with AutomaticKeepAliveClientMixin {
  late ChatController controller;

  @override
  void initState() {
    super.initState();

    controller = Get.find();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: CommonUtil.hexColor(0xA1A8B0).withAlpha(50),
        padding: EdgeInsets.fromLTRB(24.w, 16.w + ScreenUtil().statusBarHeight,
            24.w, 16.w + ScreenUtil().bottomBarHeight),
        child: Column(children: [
          Row(
            children: [
              Expanded(
                  child: Text(
                'Chat',
                style: TextStyle(fontSize: 32.sp, fontWeight: FontWeight.bold),
              ))
            ],
          ),
          SizedBox(height: 24.w),
          ValueListenableBuilder(
              valueListenable:
                  Hive.box(BusinessConstants.chatMsgBox).listenable(),
              builder: (context, box, _) {
                return box.values.isEmpty
                    ? _buildEmptyMsgWidget()
                    : Expanded(child: _buildMsgListWidget(context));
              })
        ]));
  }

  // 空消息列表Widget
  Widget _buildEmptyMsgWidget() {
    return Expanded(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
            onTap: () {
              NavController navController = Get.find();
              navController.tabIndex.value = 0;
              navController.pageController.jumpToPage(0);
            },
            child: AppImage.asset(
                '${BusinessConstants.imgPathPrefix}/chat/empty_message.png',
                width: 200.w,
                height: 160.w)),
        SizedBox(height: 16.w),
        Text('Add Friends',
            style: TextStyle(
                fontSize: 12.sp, color: CommonUtil.hexColor(0x838AA0)))
      ],
    ));
  }

  // 消息列表widget
  Widget _buildMsgListWidget(BuildContext context) {
    List<String> avtarList = [
      'avtar1.png',
      'avtar2.png',
      'avtar3.png',
      'avtar4.png'
    ];

    return ValueListenableBuilder(
        valueListenable: Hive.box(BusinessConstants.chatMsgBox).listenable(),
        builder: (context, box, _) {
          List<ChatModel> recentChatList = _filterChatList(box.values);

          return MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: ListView.separated(
                itemBuilder: (context, index) {
                  ChatModel chatModel = recentChatList[index];

                  return GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      Records record = Records();
                      record.characterId = chatModel.characterId;
                      record.name = chatModel.characterName;
                      record.portraitUrl = chatModel.portraitUrl;

                      Get.toNamed(RouterName.chatPageRouter, arguments: record);
                    },
                    child: _buildItem(chatModel),
                  );
                },
                separatorBuilder: (context, index) {
                  return Divider(
                      thickness: 1.w, color: Colors.black.withAlpha(12));
                },
                itemCount: recentChatList.length,
                shrinkWrap: true,
              ));
        });
  }

  // 筛选出聊天列表里的最后一条消息数组
  List<ChatModel> _filterChatList(Iterable<dynamic> chatList) {
    List<ChatModel> recentChatList = [];

    if (chatList.isNotEmpty) {
      List<int> characterIdList = [];
      for (var chatModel in chatList) {
        if (chatModel.characterId != null &&
            !characterIdList.contains(chatModel.characterId)) {
          characterIdList.add(chatModel.characterId!);
        }
      }

      for (var characterId in characterIdList) {
        ChatModel chatModel =
            chatList.lastWhere((element) => element.characterId == characterId);
        recentChatList.add(chatModel);
      }
    }

    return recentChatList;
  }

  Widget _buildItem(ChatModel chatModel) {
    return Container(
        height: 80.w,
        padding: EdgeInsets.symmetric(vertical: 8.w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(100.w)),
              child: AppImage.asset(
                  '${BusinessConstants.imgPathPrefix}/chat/avtar1.png',
                  width: 64.w,
                  height: 64.w),
            ),
            SizedBox(width: 12.w),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Expanded(
                        child: Text(
                      chatModel.characterName,
                      style: TextStyle(
                          fontSize: 16.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.w600),
                    )),
                    Text(
                      flustars.DateUtil.formatDateMs(chatModel.msgTime,
                          format: flustars.DateFormats.y_mo_d_h_m),
                      style: TextStyle(
                        fontSize: 10.sp,
                        color: CommonUtil.hexColor(0xC2C9D1),
                      ),
                    )
                  ],
                ),
                Flexible(
                    child: Text(
                  chatModel.msgContent,
                  style: TextStyle(
                    fontSize: 14.sp,
                    overflow: TextOverflow.ellipsis,
                    color: Colors.black,
                  ),
                ))
              ],
            )),
          ],
        ));
  }

  @override
  bool get wantKeepAlive => true;
}
