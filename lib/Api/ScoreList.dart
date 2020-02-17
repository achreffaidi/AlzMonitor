// To parse this JSON data, do
//
//     final scoreList = scoreListFromJson(jsonString);

import 'dart:convert';

class ScoreList {
  List<ScoreListElement> scoreList;

  ScoreList({
    this.scoreList,
  });

  factory ScoreList.fromJson(String str) => ScoreList.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ScoreList.fromMap(Map<String, dynamic> json) => ScoreList(
    scoreList: json["scoreList"] == null ? null : List<ScoreListElement>.from(json["scoreList"].map((x) => ScoreListElement.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "scoreList": scoreList == null ? null : List<dynamic>.from(scoreList.map((x) => x.toMap())),
  };
}

class ScoreListElement {
  double rapport;
  DateTime date;

  ScoreListElement({
    this.rapport,
    this.date,
  });

  factory ScoreListElement.fromJson(String str) => ScoreListElement.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ScoreListElement.fromMap(Map<String, dynamic> json) => ScoreListElement(
    rapport: json["rapport"] == null ? null : json["rapport"].toDouble(),
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
  );

  Map<String, dynamic> toMap() => {
    "rapport": rapport == null ? null : rapport,
    "date": date == null ? null : date.toIso8601String(),
  };
}
