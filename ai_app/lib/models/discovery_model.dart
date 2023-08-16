class DiscoveryModel {
  List<Records>? records;
  int? total;

  DiscoveryModel({this.records, this.total});

  DiscoveryModel.fromJson(Map<String, dynamic> json) {
    if (json["records"] is List) {
      records = json["records"] == null
          ? null
          : (json["records"] as List).map((e) => Records.fromJson(e)).toList();
    }
    if (json["total"] is int) {
      total = json["total"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if (records != null) {
      _data["records"] = records?.map((e) => e.toJson()).toList();
    }
    _data["total"] = total;
    return _data;
  }
}

class Records {
  String? about;
  int? characterId;
  int? createTime;
  int? modifyTime;
  String? name;
  String? portraitUrl;
  String? pronouns;
  String? greeting;
  List<String>? tags;
  List<String>? topic;

  Records(
      {this.about,
      this.characterId,
      this.createTime,
      this.modifyTime,
      this.name,
      this.greeting,
      this.portraitUrl,
      this.pronouns,
      this.tags,
      this.topic});

  Records.fromJson(Map<String, dynamic> json) {
    if (json["about"] is String) {
      about = json["about"];
    }
    if (json["characterId"] is int) {
      characterId = json["characterId"];
    }
    if (json["createTime"] is int) {
      createTime = json["createTime"];
    }
    if (json["modifyTime"] is int) {
      modifyTime = json["modifyTime"];
    }
    if (json["name"] is String) {
      name = json["name"];
    }
    if (json["greeting"] is String) {
      greeting = json["greeting"];
    }
    if (json["portraitUrl"] is String) {
      portraitUrl = json["portraitUrl"];
    }
    if (json["pronouns"] is String) {
      pronouns = json["pronouns"];
    }
    if (json["tags"] is List) {
      tags = json["tags"] == null ? null : List<String>.from(json["tags"]);
    }
    if (json["topic"] is List) {
      topic = json["topic"] == null ? null : List<String>.from(json["topic"]);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["about"] = about;
    _data["characterId"] = characterId;
    _data["createTime"] = createTime;
    _data["modifyTime"] = modifyTime;
    _data["name"] = name;
    _data["portraitUrl"] = portraitUrl;
    _data["pronouns"] = pronouns;
    _data["greeting"] = greeting;
    if (tags != null) {
      _data["tags"] = tags;
    }
    if (topic != null) {
      _data["topic"] = topic;
    }
    return _data;
  }
}
