import 'package:app/contants/business_constants.dart';
import 'package:app/controller/chat_controller.dart';
import 'package:app/models/chat_model.dart';
import 'package:app/models/chat_request_model.dart';
import 'package:app/models/discovery_model.dart';
import 'package:app/utils/common_util.dart';
import 'package:app/utils/db_util.dart';
import 'package:app/widgets/common/app_image.dart';
import 'package:flustars/flustars.dart' as flustars;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ChatPage extends GetView<ChatController> {
  ChatPage({super.key});

  Records? record;

  final TextEditingController _msgTextController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    record = Get.arguments;

    Future.delayed(const Duration(milliseconds: 200), () {
      // 列表滚动到底部
      _scrollController.jumpTo(
        _scrollController.position.maxScrollExtent,
      );
    });

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CommonUtil.getBgAppBar(record?.name ?? '', actions: [
        Padding(
            padding: EdgeInsets.only(right: 16.w),
            child: GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Text(
                  '...',
                  style: TextStyle(color: Colors.black, fontSize: 18.sp),
                )))
      ]),
      body: Column(
        children: [
          Expanded(
              child: Container(
            width: 1.sw,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                        '${BusinessConstants.imgPathPrefix}/chat/chat_bg.png'),
                    fit: BoxFit.fill)),
            child: ValueListenableBuilder(
                valueListenable:
                    Hive.box(BusinessConstants.chatMsgBox).listenable(),
                builder: (context, box, widget) {
                  // 筛选出属于当前聊天characterId的消息列表
                  List<ChatModel> currentChatList = [];

                  for (ChatModel chatModel in box.values) {
                    if (chatModel.characterId == record?.characterId) {
                      currentChatList.add(chatModel);
                    }
                  }

                  return Container(
                      margin: EdgeInsets.only(top: 93.w),
                      child: ListView.separated(
                        controller: _scrollController,
                        padding: EdgeInsets.fromLTRB(24.w, 10.w, 24.w, 24.w),
                        itemBuilder: (context, index) {
                          ChatModel chatModel = currentChatList[index];
                          // 发送消息cell
                          if (chatModel.isSend == 0) {
                            return _buildSendCell(chatModel);
                          } else {
                            // 接收消息cell
                            return _buildReceiveWidget(chatModel);
                          }
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(height: 24.w);
                        },
                        shrinkWrap: true,
                        itemCount: currentChatList.length,
                      ));
                }),
          )),
          Obx(() => Container(
                alignment: Alignment.center,
                color: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  children: [
                    Row(children: [
                      GestureDetector(
                        onTap: () {
                          controller.showQuicklyMsg.value =
                              !controller.showQuicklyMsg.value;
                        },
                        child: AppImage.asset(
                            '${BusinessConstants.imgPathPrefix}/chat/quickly_msg.png',
                            width: 24.w,
                            height: 24.w),
                      ),
                      SizedBox(width: 27.w),
                      Expanded(
                          child: TextField(
                        controller: _msgTextController,
                        decoration: const InputDecoration(
                            border: InputBorder.none, hintText: 'Type Messgae'),
                      )),
                      GestureDetector(
                          onTap: () {
                            _sendMsg(context);
                          },
                          child: AppImage.asset(
                              '${BusinessConstants.imgPathPrefix}/chat/send_msg.png',
                              width: 24.w,
                              height: 24.w))
                    ]),
                    controller.showQuicklyMsg.value
                        ? _buildQuicklyMsgWidget(context)
                        : SizedBox(
                            height: ScreenUtil().bottomBarHeight,
                          )
                  ],
                ),
              )),
        ],
      ),
    );
  }

  // 发送消息事件
  void _sendMsg(BuildContext context) {
    if (_msgTextController.text.isNotEmpty) {
      int accountId =
          flustars.SpUtil.getInt(BusinessConstants.accountIdKey) ?? -1;
      ChatRequestModel model = ChatRequestModel();
      model.accountId = accountId;
      model.characterId = record?.characterId;
      model.message = _msgTextController.text;
      controller.chat(model, successCallback: (data) {
        _msgTextController.text = '';
        FocusScope.of(context).unfocus();
        // 存储发送的消息
        ChatModel sendModel = ChatModel(
            model.accountId!,
            model.characterId!,
            '',
            model.message!,
            DateTime.now().millisecondsSinceEpoch,
            0,
            record?.name ?? '');
        DbUtil.shared.chatMsgBox.add(sendModel);
        sendModel.save();
        // 存储接收的消息
        ChatModel receiveModel = ChatModel(
            model.accountId!,
            model.characterId!,
            '',
            data.toString(),
            DateTime.now().millisecondsSinceEpoch,
            1,
            record?.name ?? '');
        DbUtil.shared.chatMsgBox.add(receiveModel);
        receiveModel.save();
        // 获取回复推荐消息
        controller.recommendResponse(model);
        // 列表滚动到底部
        _scrollController.animateTo(_scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 200), curve: Curves.ease);
      });
    }
  }

  // 发送消息cell
  Widget _buildSendCell(ChatModel chatModel) {
    return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(width: 40.w),
          Flexible(
              fit: FlexFit.loose,
              child: Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(12.w)),
                    color: CommonUtil.hexColor(0xFF0C57)),
                child: Text(chatModel.msgContent,
                    style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.w400)),
              )),
          SizedBox(width: 12.w),
          ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(100.w)),
              child: Image.asset(
                  '${BusinessConstants.imgPathPrefix}/chat/avtar1.png',
                  width: 36.w,
                  height: 36.w)),
        ]);
  }

  // 接收消息cell
  Widget _buildReceiveWidget(ChatModel chatModel) {
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(100.w)),
          child: Image.asset(
              '${BusinessConstants.imgPathPrefix}/chat/avtar2.png',
              width: 36.w,
              height: 36.w)),
      SizedBox(width: 12.w),
      Flexible(
          child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(12.w)),
            color: Colors.white),
        child: Text(chatModel.msgContent,
            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400)),
      )),
      SizedBox(width: 40.w)
    ]);
  }

  // 快捷消息Widget
  Widget _buildQuicklyMsgWidget(BuildContext context) {
    return Obx(() => MediaQuery.removePadding(
        removeLeft: true,
        removeRight: true,
        removeTop: true,
        context: context,
        child: ListView.separated(
            itemBuilder: ((context, index) {
              String msg = controller.quciklyMsgList[index];
              return GestureDetector(
                  onTap: () {
                    _msgTextController.text = msg;
                    _sendMsg(context);
                  },
                  child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 12.w),
                      child: Text(
                        msg,
                        style: TextStyle(fontSize: 14.sp),
                      )));
            }),
            separatorBuilder: (context, index) {
              return Divider(
                  height: 1.w,
                  thickness: 1.w,
                  color: Colors.black.withAlpha(12));
            },
            shrinkWrap: true,
            itemCount: controller.quciklyMsgList.length)));
  }
}
