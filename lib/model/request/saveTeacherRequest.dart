class SaveTeacherRequest {
  String name;
  String login;
  String password;


  SaveTeacherRequest(this.name, this.login, this.password);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map["name"] = name;
    map["login"] = login;
    map["password"] = password;
    return map;
  }
}
