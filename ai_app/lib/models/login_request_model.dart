class LoginRequestModel {
  String? accountTypeEnum;
  String? appleId;
  String? email;
  String? googleId;
  String? password;

  LoginRequestModel(
      {this.accountTypeEnum,
      this.appleId,
      this.email,
      this.googleId,
      this.password});

  LoginRequestModel.fromJson(Map<String, dynamic> json) {
    if (json["accountTypeEnum"] is String) {
      accountTypeEnum = json["accountTypeEnum"];
    }
    if (json["appleId"] is String) {
      appleId = json["appleId"];
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
    _data["password"] = password;
    return _data;
  }
}
