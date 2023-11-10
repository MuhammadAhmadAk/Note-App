class UserModel {
  String? uid;
  String? username;
  String? email;
  String? password;

  UserModel({
    this.uid,
    this.username,
    this.email,
    this.password,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    uid = json["_id"];
    username = json["username"];
    email = json["email"];
    password = json["password"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["uid"] = uid;
    _data["username"] = username;
    _data["email"] = email;
    _data["password"] = password;
    return _data;
  }
}
