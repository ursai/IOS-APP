class LoginRequestModel {
  String? accountTypeEnum;
  String? appleId;
  String? email;
  String? googleId;
  String? password;
  String? loginKey;

  LoginRequestModel(
      {this.accountTypeEnum,
      this.appleId,
      this.email,
      this.googleId,
      this.loginKey,
      this.password});

  LoginRequestModel.fromJson(Map<String, dynamic> json) {
    if (json["accountTypeEnum"] is String) {
      accountTypeEnum = json["accountTypeEnum"];
    }
    if (json["appleId"] is String) {
      appleId = json["appleId"];
    }
    if (json["loginKey"] is String) {
      loginKey = json["loginKey"];
    }
    if (json["email"] is String) {
      email = json["email"];
    }
    if (json["googleId"] is String) {
      googleId = json["googleId"];
    }
    if (json["password"] is String) {
      password = json["password"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["accountTypeEnum"] = accountTypeEnum;
    _data["appleId"] = appleId;
    _data["email"] = email;
    _data["googleId"] = googleId;
    _data["loginKey"] = loginKey;
    _data["password"] = password;
    return _data;
  }
}
