class UpdateUserInfoModel {
  int? accountId;
  String? birth;
  String? pronounsTypeEnum;
  String? userName;

  UpdateUserInfoModel(
      {this.accountId, this.birth, this.pronounsTypeEnum, this.userName});

  UpdateUserInfoModel.fromJson(Map<String, dynamic> json) {
    if (json["accountId"] is int) {
      accountId = json["accountId"];
    }
    if (json["birth"] is String) {
      birth = json["birth"];
    }
    if (json["pronounsTypeEnum"] is String) {
      pronounsTypeEnum = json["pronounsTypeEnum"];
    }
    if (json["userName"] is String) {
      userName = json["userName"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["accountId"] = accountId;
    _data["birth"] = birth;
    _data["pronounsTypeEnum"] = pronounsTypeEnum;
    _data["userName"] = userName;
    return _data;
  }
}
