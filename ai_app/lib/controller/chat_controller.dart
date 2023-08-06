import 'package:app/contants/api_path.dart';
import 'package:app/models/chat_request_model.dart';
import 'package:app/network/api_client.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  // 是否显示快捷消息
  var showQuicklyMsg = false.obs;
  // 快捷回复消息列表
  var quciklyMsgList = [].obs;

  // 聊天接口
  void chat(ChatRequestModel chatRequestModel, {Function? successCallback}) {
    ApiClient().post(ApiPath.chatApi,
        isShowLoading: false,
        data: chatRequestModel.toJson(), successCallback: (data) {
      debugPrint(data);
      if (successCallback != null) {
        successCallback(data);
      }
    });
  }

  // 聊天推荐回复接口
  void recommendResponse(ChatRequestModel chatRequestModel,
      {Function? successCallback}) {
    ApiClient().post(ApiPath.recommendResponseApi,
        isShowLoading: false,
        data: chatRequestModel.toJson(), successCallback: (data) {
      quciklyMsgList.value = data['responses'];
      if (successCallback != null) {
        successCallback();
      }
    });
  }
}
