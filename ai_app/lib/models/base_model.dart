class BaseModel {
  int? code;
  String? message;
  dynamic data;
  bool? success;
  String? time;

  BaseModel({this.code, this.message, this.data, this.success, this.time});
  BaseModel.fromJson(Map<String, dynamic> json) {
    code = json["code"];
    message = json["message"];
    data = json["data"];
    success = json["success"];
    time = json["time"];
  }
}
