// To parse this JSON data, do
//
//     final tasks = tasksFromJson(jsonString);

import 'dart:convert';

class Tasks {
  List<ListElement> list;

  Tasks({
    this.list,
  });

  factory Tasks.fromJson(String str) => Tasks.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Tasks.fromMap(Map<String, dynamic> json) => Tasks(
    list: json["list"] == null ? null : List<ListElement>.from(json["list"].map((x) => ListElement.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "list": list == null ? null : List<dynamic>.from(list.map((x) => x.toMap())),
  };
}

class ListElement {
  int id;
  int day;
  String time;
  String title;
  bool done;

  ListElement({
    this.id,
    this.day,
    this.time,
    this.title,
    this.done,
  });

  factory ListElement.fromJson(String str) => ListElement.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ListElement.fromMap(Map<String, dynamic> json) => ListElement(
    id: json["id"] == null ? null : json["id"],
    day: json["day"] == null ? null : json["day"],
    time: json["time"] == null ? null : json["time"],
    title: json["title"] == null ? null : json["title"],
    done: json["done"] == null ? null : json["done"],
  );

  Map<String, dynamic> toMap() => {
    "id": id == null ? null : id,
    "day": day == null ? null : day,
    "time": time == null ? null : time,
    "title": title == null ? null : title,
    "done": done == null ? null : done,
  };
}
