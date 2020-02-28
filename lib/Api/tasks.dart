// To parse this JSON data, do
//
//     final tasks = tasksFromJson(jsonString);

import 'dart:convert';

class Tasks {
  List<ListByDay> listByDay;

  Tasks({
    this.listByDay,
  });

  factory Tasks.fromJson(String str) => Tasks.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Tasks.fromMap(Map<String, dynamic> json) => Tasks(
    listByDay: json["listByDay"] == null ? null : List<ListByDay>.from(json["listByDay"].map((x) => ListByDay.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "listByDay": listByDay == null ? null : List<dynamic>.from(listByDay.map((x) => x.toMap())),
  };
}

class ListByDay {
  bool done;
  String image;
  String id;
  String title;
  String description;
  int priority;
  String time;
  String voice;
  String voiceLink;
  String name;
  int day;
  int v;

  ListByDay({
    this.done,
    this.image,
    this.id,
    this.title,
    this.description,
    this.priority,
    this.time,
    this.voice,
    this.voiceLink,
    this.name,
    this.day,
    this.v,
  });

  factory ListByDay.fromJson(String str) => ListByDay.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ListByDay.fromMap(Map<String, dynamic> json) => ListByDay(
    done: json["done"] == null ? null : json["done"],
    image: json["image"] == null ? null : json["image"],
    id: json["_id"] == null ? null : json["_id"],
    title: json["title"] == null ? null : json["title"],
    description: json["description"] == null ? null : json["description"],
    priority: json["priority"] == null ? null : json["priority"],
    time: json["time"] == null ? null : json["time"],
    voice: json["voice"] == null ? null : json["voice"],
    voiceLink: json["voiceLink"] == null ? null : json["voiceLink"],
    name: json["name"] == null ? null : json["name"],
    day: json["day"] == null ? null : json["day"],
    v: json["__v"] == null ? null : json["__v"],
  );

  Map<String, dynamic> toMap() => {
    "done": done == null ? null : done,
    "image": image == null ? null : image,
    "_id": id == null ? null : id,
    "title": title == null ? null : title,
    "description": description == null ? null : description,
    "priority": priority == null ? null : priority,
    "time": time == null ? null : time,
    "voice": voice == null ? null : voice,
    "voiceLink": voiceLink == null ? null : voiceLink,
    "name": name == null ? null : name,
    "day": day == null ? null : day,
    "__v": v == null ? null : v,
  };
}
