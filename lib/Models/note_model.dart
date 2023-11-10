
class NoteModel {
  String? id;
  String? title;
  String? description;
  String? creatorId;
  int? createAt;

  NoteModel({this.id, this.title, this.description, this.creatorId, this.createAt});

  NoteModel.fromJson(Map<String, dynamic> json) {
    id = json["_id"];
    title = json["title"];
    description = json["description"];
    creatorId = json["creatorId"];
    createAt = json["createAt"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["_id"] = id;
    _data["title"] = title;
    _data["description"] = description;
    _data["creatorId"] = creatorId;
    _data["createAt"] = createAt;
    return _data;
  }
}