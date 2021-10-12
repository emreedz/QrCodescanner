
class TodoVeri {

  int? userId;
  int? id;
  String? title;
  bool? completed;

  TodoVeri({
    this.userId,
    this.id,
    this.title,
    this.completed,
  });
  TodoVeri.fromJson(Map<String, dynamic> json) {
    userId = json["userId"]?.toInt();
    id = json["id"]?.toInt();
    title = json["title"]?.toString();
    completed = json["completed"];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["userId"] = userId;
    data["id"] = id;
    data["title"] = title;
    data["completed"] = completed;
    return data;
  }
}
