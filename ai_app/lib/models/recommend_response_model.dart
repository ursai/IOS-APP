
class RecommendResponseModel {
  List<String>? responses;

  RecommendResponseModel({this.responses});

  RecommendResponseModel.fromJson(Map<String, dynamic> json) {
    if(json["responses"] is List) {
      responses = json["responses"] == null ? null : List<String>.from(json["responses"]);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if(responses != null) {
      _data["responses"] = responses;
    }
    return _data;
  }
}