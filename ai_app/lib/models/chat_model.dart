import 'package:hive/hive.dart';

part 'chat_model.g.dart';

enum MsgType {
  msgTypeNormal,
  msgTypeAbout, // about消息
  msgTypeTopic, // topic提示消息
}

@HiveType(typeId: 0)
class ChatModel extends HiveObject {
  @HiveField(0)
  int accountId = -1;
  @HiveField(1)
  int characterId = -1;
  @HiveField(2)
  String portraitUrl = '';
  @HiveField(3)
  int msgTime = 0;
  @HiveField(4)
  String msgContent = '';
  @HiveField(5)
  int isSend = 0; // 0:发送消息，1:接收消息
  @HiveField(6)
  String characterName;
  @HiveField(7)
  int msgType;

  ChatModel(this.accountId, this.characterId, this.portraitUrl, this.msgContent,
      this.msgTime, this.isSend, this.characterName, this.msgType);

  @override
  String toString() {
    return '$accountId, $characterId, $msgContent, $isSend';
  }
}
