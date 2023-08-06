
class ChatRequestModel {
  int? accountId;
  int? characterId;
  String? message;

  ChatRequestModel({this.accountId, this.characterId, this.message});

  ChatRequestModel.fromJson(Map<String, dynamic> json) {
    if(json["accountId"] is int) {
      accountId = json["accountId"];
    }
    if(json["characterId"] is int) {
      characterId = json["characterId"];
    }
    if(json["message"] is String) {
      message = json["message"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["accountId"] = accountId;
    _data["characterId"] = characterId;
    _data["message"] = message;
    return _data;
  }
}