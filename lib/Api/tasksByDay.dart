// To parse this JSON data, do
//
//     final tasksByDay = tasksByDayFromJson(jsonString);

import 'dart:convert';

import 'package:monitor/Api/tasks.dart';

class TasksByDay {
  List<ListByDay> listByDay;

  TasksByDay({
    this.listByDay,
  });

  factory TasksByDay.fromJson(String str) => TasksByDay.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TasksByDay.fromMap(Map<String, dynamic> json) => TasksByDay(
    listByDay: json["listByDay"] == null ? null : List<ListByDay>.from(json["listByDay"].map((x) => ListByDay.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "listByDay": listByDay == null ? null : List<dynamic>.from(listByDay.map((x) => x.toMap())),
  };
}

class ListByDay {
  bool done;
  String imageUrl;
  String id;
  String title;
  String description;
  String time;
  String imageId;
  String voice;
  String voiceLink;
  String name;
  int day;
  int priority;
  String category;
  int v;

  ListByDay({
    this.done,
    this.imageUrl,
    this.id,
    this.title,
    this.description,
    this.time,
    this.imageId,
    this.voice,
    this.voiceLink,
    this.name,
    this.day,
    this.priority,
    this.category,
    this.v,
  });

  factory ListByDay.fromJson(String str) => ListByDay.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ListByDay.fromMap(Map<String, dynamic> json) => ListByDay(
    done: json["done"] == null ? null : json["done"],
    imageUrl: json["imageURL"] == null ? null : json["imageURL"],
    id: json["_id"] == null ? null : json["_id"],
    title: json["title"] == null ? null : json["title"],
    description: json["description"] == null ? null : json["description"],
    time: json["time"] == null ? null : json["time"],
    imageId: json["imageId"] == null ? null : json["imageId"],
    voice: json["voice"] == null ? null : json["voice"],
    voiceLink: json["voiceLink"] == null ? null : json["voiceLink"],
    name: json["name"] == null ? null : json["name"],
    day: json["day"] == null ? null : json["day"],
    priority: json["priority"] == null ? null : json["priority"],
    category: json["category"] == null ? null : json["category"],
    v: json["__v"] == null ? null : json["__v"],
  );

  Map<String, dynamic> toMap() => {
    "done": done == null ? null : done,
    "imageURL": imageUrl == null ? null : imageUrl,
    "_id": id == null ? null : id,
    "title": title == null ? null : title,
    "description": description == null ? null : description,
    "time": time == null ? null : time,
    "imageId": imageId == null ? null : imageId,
    "voice": voice == null ? null : voice,
    "voiceLink": voiceLink == null ? null : voiceLink,
    "name": name == null ? null : name,
    "day": day == null ? null : day,
    "priority": priority == null ? null : priority,
    "category": category == null ? null : category,
    "__v": v == null ? null : v,
  };


}
