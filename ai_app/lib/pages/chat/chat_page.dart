import 'package:app/contants/business_constants.dart';
import 'package:app/controller/chat_controller.dart';
import 'package:app/controller/discovery_controller.dart';
import 'package:app/controller/mine_controller.dart';
import 'package:app/models/chat_model.dart';
import 'package:app/models/discovery_model.dart';
import 'package:app/models/fast_chat_model.dart';
import 'package:app/utils/common_util.dart';
import 'package:app/utils/db_util.dart';
import 'package:app/widgets/common/app_image.dart';
import 'package:flustars/flustars.dart' as flustars;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with WidgetsBindingObserver {
  late Records? record;
  late ChatController controller;
  late MineController mineController;
  late DisCoveryController disCoveryController;
  final TextEditingController _msgTextController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    Get.put(ChatController());
    controller = Get.find();
    mineController = Get.find();

    record = Get.arguments;
    // 如果第一次聊天展示About me和greet消息
    bool? firstChat =
        flustars.SpUtil.getBool('${record?.characterId}', defValue: true);
    if (firstChat == true) {
      _createGreetMessage();
      flustars.SpUtil.putBool('${record?.characterId}', false);
    }
    // 如果有topic带入，需弹出topic消息
    disCoveryController = Get.find();
    String? topic = disCoveryController.selectedTopicMap[record?.characterId];
    if (topic != null) {
      bool showTopic = disCoveryController.showTopicMap[topic] ?? false;
      if (showTopic == false) {
        _createTopicMessage();
        disCoveryController.showTopicMap[topic] = true;
      }
    }

    Future.delayed(const Duration(milliseconds: 200), () {
      // 列表滚动到底部
      _scrollController.jumpTo(
        _scrollController.position.maxScrollExtent,
      );
    });
    // 获取自动推荐

    int accountId = mineController.loginModel.value.accountId ?? -1;
    FastChatModel model = FastChatModel();
    model.accountId = accountId;
    model.characterId = record?.characterId;
    controller.recommendResponse(model);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CommonUtil.getBgAppBar(record?.name ?? '', actions: [
        Padding(
            padding: EdgeInsets.only(right: 16.w),
            child: GestureDetector(
                onTap: () {
                  Get.back();
                  controller.showQuicklyMsg.value = false;
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
                          // about me消息cell
                          if (chatModel.msgType == MsgType.msgTypeAbout.index) {
                            return Container(
                              padding: EdgeInsets.symmetric(horizontal: 40.w),
                              child: Row(
                                children: [
                                  Expanded(
                                      child: Text(chatModel.msgContent,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(fontSize: 14.sp)))
                                ],
                              ),
                            );
                          } else if (chatModel.msgType ==
                              MsgType.msgTypeTopic.index) {
                            // topic提示消息cell
                            return Container(
                              width: 1.sw,
                              decoration: BoxDecoration(
                                  color: Colors.white.withAlpha(204),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12.w))),
                              margin: EdgeInsets.symmetric(horizontal: 50.w),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 25.w, vertical: 12.w),
                              child: Row(
                                children: [
                                  Expanded(
                                      child: Text(chatModel.msgContent,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(fontSize: 14.sp)))
                                ],
                              ),
                            );
                          }
                          // 发送消息cell
                          else if (chatModel.isSend == 0) {
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
                        : const SizedBox.shrink()
                  ],
                ),
              )),
        ],
      ),
    );
  }

  // 创建About me和greet消息
  void _createGreetMessage() {
    // 存储Aboutme消息
    int accountId = mineController.loginModel.value.accountId ?? -1;
    ChatModel aboutModel = ChatModel(
        accountId,
        record?.characterId ?? -1,
        '',
        record?.about ?? '',
        DateTime.now().millisecondsSinceEpoch,
        0,
        record?.name ?? '',
        MsgType.msgTypeAbout.index);
    DbUtil.shared.chatMsgBox.add(aboutModel);
    aboutModel.save();
    // 存储Greet消息
    ChatModel greetModel = ChatModel(
        accountId,
        record?.characterId ?? -1,
        '',
        record?.greeting ?? '',
        DateTime.now().millisecondsSinceEpoch,
        1,
        record?.name ?? '',
        MsgType.msgTypeNormal.index);
    DbUtil.shared.chatMsgBox.add(greetModel);
    greetModel.save();
  }

  // 创建topic消息
  void _createTopicMessage() {
    // 存储topic消息
    int accountId = mineController.loginModel.value.accountId ?? -1;
    String topic =
        disCoveryController.selectedTopicMap[record?.characterId] ?? '';
    ChatModel topicModel = ChatModel(
        accountId,
        record?.characterId ?? -1,
        '',
        topic,
        DateTime.now().millisecondsSinceEpoch,
        0,
        record?.name ?? '',
        MsgType.msgTypeTopic.index);
    DbUtil.shared.chatMsgBox.add(topicModel);
    topicModel.save();
  }

  // 发送消息事件
  void _sendMsg(BuildContext context) {
    if (_msgTextController.text.isNotEmpty) {
      int accountId = mineController.loginModel.value.accountId ?? -1;
      String topic =
          disCoveryController.selectedTopicMap[record?.characterId] ?? '';

      FastChatModel model = FastChatModel();
      model.accountId = accountId;
      model.characterId = record?.characterId;
      model.message = _msgTextController.text;
      model.topic = topic;
      // 存储发送的消息
      ChatModel sendModel = ChatModel(
          model.accountId!,
          model.characterId!,
          '',
          model.message!,
          DateTime.now().millisecondsSinceEpoch,
          0,
          record?.name ?? '',
          MsgType.msgTypeNormal.index);
      DbUtil.shared.chatMsgBox.add(sendModel);
      sendModel.save();

      _msgTextController.text = '';
      FocusScope.of(context).unfocus();

      controller.topicChat(model, successCallback: (data) {
        // 存储接收的消息
        ChatModel receiveModel = ChatModel(
            model.accountId!,
            model.characterId!,
            '',
            data.toString(),
            DateTime.now().millisecondsSinceEpoch,
            1,
            record?.name ?? '',
            MsgType.msgTypeNormal.index);
        DbUtil.shared.chatMsgBox.add(receiveModel);
        receiveModel.save();
        // 获取回复推荐消息
        model.message = data.toString();
        controller.recommendResponse(model);
        // 列表滚动到底部
        Future.delayed(const Duration(milliseconds: 100), () {
          _scrollController.animateTo(
              _scrollController.position.maxScrollExtent,
              duration: const Duration(milliseconds: 200),
              curve: Curves.ease);
        });
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
                    controller.showQuicklyMsg.value = false;
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
