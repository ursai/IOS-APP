class BaseModel {
  int? code;
  String? msg;
  dynamic data;

  BaseModel({this.code, this.msg, this.data});
  BaseModel.fromJson(Map<String, dynamic> json) {
    code = json["code"];
    msg = json["msg"];
    data = json["data"];
  }
}
