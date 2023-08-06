import 'package:hive/hive.dart';

part 'chat_model.g.dart';

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

  ChatModel(this.accountId, this.characterId, this.portraitUrl, this.msgContent,
      this.msgTime, this.isSend, this.characterName);

  @override
  String toString() {
    return '$accountId, $characterId, $msgContent, $isSend';
  }
}
