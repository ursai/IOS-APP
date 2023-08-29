class ApiPath {
  static const loginApi = 'palsServiceUser/account/login';
  static const registerApi = 'palsServiceUser/account/signUp';
  static const updateUserInfoApi = 'palsServiceUser/account/update';
  static const logoutApi = 'palsServiceUser/account/logout';
  static const delAccountApi = 'palsServiceUser/account/delete';
  // 上传头像接口
  static const uploadHeaderPicApi = 'palsServiceUser/account/avatar/upload';
  // 上传推送通知token
  static const pushTokenApi = 'palsServiceUser/message/addToken';
  // 查询discovery列表
  static const queryDiscoveryApi = 'palsServiceUser/character/page';
  // 对话接口
  static const chatApi = 'palsServiceChat/langchain/chat';
  // Topic对话接口
  static const topicChatApi = 'palsServiceChat/fastChat/chat';
  // 对话推荐回复接口
  static const recommendResponseApi =
      'palsServiceChat/langchain/responseRecommend';
}
