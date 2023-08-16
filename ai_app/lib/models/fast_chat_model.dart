class FastChatModel {
  int? accountId;
  int? characterId;
  String? message;
  String? topic;

  FastChatModel({this.accountId, this.characterId, this.message, this.topic});

  FastChatModel.fromJson(Map<String, dynamic> json) {
    if (json["accountId"] is int) {
      accountId = json["accountId"];
    }
    if (json["characterId"] is int) {
      characterId = json["characterId"];
    }
    if (json["message"] is String) {
      message = json["message"];
    }
    if (json["topic"] is String) {
      topic = json["topic"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["accountId"] = accountId;
    _data["characterId"] = characterId;
    _data["message"] = message;
    _data["topic"] = topic;
    return _data;
  }
}
