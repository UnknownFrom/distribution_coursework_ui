class Student {
  int id;
  String name;

  Student(this.name);

  Student.empty()
      : id = null,
        name = null;

  Student.fromJson(dynamic obj) {
    id = obj["id"];
    name = obj["name"];
  }
}
