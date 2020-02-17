// To parse this JSON data, do
//
//     final lastGame = lastGameFromJson(jsonString);

import 'dart:convert';

class LastGame {
  LastScore lastScore;

  LastGame({
    this.lastScore,
  });

  factory LastGame.fromJson(String str) => LastGame.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory LastGame.fromMap(Map<String, dynamic> json) => LastGame(
    lastScore: json["lastScore"] == null ? null : LastScore.fromMap(json["lastScore"]),
  );

  Map<String, dynamic> toMap() => {
    "lastScore": lastScore == null ? null : lastScore.toMap(),
  };
}

class LastScore {
  String id;
  DateTime date;
  String scoreId;
  int questionsNumber;
  int correct;
  double rapport;
  int v;

  LastScore({
    this.id,
    this.date,
    this.scoreId,
    this.questionsNumber,
    this.correct,
    this.rapport,
    this.v,
  });

  factory LastScore.fromJson(String str) => LastScore.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory LastScore.fromMap(Map<String, dynamic> json) => LastScore(
    id: json["_id"] == null ? null : json["_id"],
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    scoreId: json["scoreId"] == null ? null : json["scoreId"],
    questionsNumber: json["questionsNumber"] == null ? null : json["questionsNumber"],
    correct: json["correct"] == null ? null : json["correct"],
    rapport: json["rapport"] == null ? null : json["rapport"].toDouble(),
    v: json["__v"] == null ? null : json["__v"],
  );

  Map<String, dynamic> toMap() => {
    "_id": id == null ? null : id,
    "date": date == null ? null : date.toIso8601String(),
    "scoreId": scoreId == null ? null : scoreId,
    "questionsNumber": questionsNumber == null ? null : questionsNumber,
    "correct": correct == null ? null : correct,
    "rapport": rapport == null ? null : rapport,
    "__v": v == null ? null : v,
  };
}
