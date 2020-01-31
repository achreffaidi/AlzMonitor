// To parse this JSON data, do
//
//     final tips = tipsFromJson(jsonString);

import 'dart:convert';

class Tips {
  List<TipsList> lists;

  Tips({
    this.lists,
  });

  factory Tips.fromJson(String str) => Tips.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Tips.fromMap(Map<String, dynamic> json) => Tips(
    lists: json["lists"] == null ? null : List<TipsList>.from(json["lists"].map((x) => TipsList.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "lists": lists == null ? null : List<dynamic>.from(lists.map((x) => x.toMap())),
  };
}

class TipsList {
  String title;
  List<ListList> list;
  String link;

  TipsList({
    this.title,
    this.list,
    this.link,
  });

  factory TipsList.fromJson(String str) => TipsList.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TipsList.fromMap(Map<String, dynamic> json) => TipsList(
    title: json["title"] == null ? null : json["title"],
    list: json["list"] == null ? null : List<ListList>.from(json["list"].map((x) => ListList.fromMap(x))),
    link: json["link"] == null ? null : json["link"],
  );

  Map<String, dynamic> toMap() => {
    "title": title == null ? null : title,
    "list": list == null ? null : List<dynamic>.from(list.map((x) => x.toMap())),
    "link": link == null ? null : link,
  };
}

class ListList {
  String title;
  String description;

  ListList({
    this.title,
    this.description,
  });

  factory ListList.fromJson(String str) => ListList.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ListList.fromMap(Map<String, dynamic> json) => ListList(
    title: json["title"] == null ? null : json["title"],
    description: json["description"] == null ? null : json["description"],
  );

  Map<String, dynamic> toMap() => {
    "title": title == null ? null : title,
    "description": description == null ? null : description,
  };
}