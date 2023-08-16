import 'dart:ffi';

class LoginModel {
  int? accountId;
  String? accountTypeEnum;
  String? appleId;
  String? birth;
  Int64? createTime;
  String? email;
  String? googleId;
  Int64? modifyTime;
  String? pronounsTypeEnum;
  String? token;
  String? userName;

  LoginModel(
      {this.accountId,
      this.accountTypeEnum,
      this.appleId,
      this.birth,
      this.createTime,
      this.email,
      this.googleId,
      this.modifyTime,
      this.pronounsTypeEnum,
      this.token,
      this.userName});

  LoginModel.fromJson(Map<dynamic, dynamic> json) {
    if (json["accountId"] is int) {
      accountId = json["accountId"];
    }
    if (json["accountTypeEnum"] is String) {
      accountTypeEnum = json["accountTypeEnum"];
    }
    if (json["appleId"] is String) {
      appleId = json["appleId"];
    }
    if (json["birth"] is String) {
      birth = json["birth"];
    }
    if (json["createTime"] is Int64) {
      createTime = json["createTime"];
    }
    if (json["email"] is String) {
      email = json["email"];
    }
    if (json["googleId"] is String) {
      googleId = json["googleId"];
    }
    if (json["modifyTime"] is Int64) {
      modifyTime = json["modifyTime"];
    }
    if (json["pronounsTypeEnum"] is String) {
      pronounsTypeEnum = json["pronounsTypeEnum"];
    }
    if (json["token"] is String) {
      token = json["token"];
    }
    if (json["userName"] is String) {
      userName = json["userName"];
    }
  }

  Map<dynamic, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["accountId"] = accountId;
    _data["accountTypeEnum"] = accountTypeEnum;
    _data["appleId"] = appleId;
    _data["birth"] = birth;
    _data["createTime"] = createTime;
    _data["email"] = email;
    _data["googleId"] = googleId;
    _data["modifyTime"] = modifyTime;
    _data["pronounsTypeEnum"] = pronounsTypeEnum;
    _data["token"] = token;
    _data["userName"] = userName;
    return _data;
  }
}
