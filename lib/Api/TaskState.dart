// To parse this JSON data, do
//
//     final taskState = taskStateFromJson(jsonString);

import 'dart:convert';

class TaskState {
  TasksStat tasksStat;

  TaskState({
    this.tasksStat,
  });

  factory TaskState.fromJson(String str) => TaskState.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TaskState.fromMap(Map<String, dynamic> json) => TaskState(
    tasksStat: json["tasksStat"] == null ? null : TasksStat.fromMap(json["tasksStat"]),
  );

  Map<String, dynamic> toMap() => {
    "tasksStat": tasksStat == null ? null : tasksStat.toMap(),
  };
}

class TasksStat {
  AllTasks allTasks;
  AllTasks priority0;
  AllTasks priority1;
  AllTasks priority2;

  TasksStat({
    this.allTasks,
    this.priority0,
    this.priority1,
    this.priority2,
  });

  factory TasksStat.fromJson(String str) => TasksStat.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TasksStat.fromMap(Map<String, dynamic> json) => TasksStat(
    allTasks: json["allTasks"] == null ? null : AllTasks.fromMap(json["allTasks"]),
    priority0: json["priority0"] == null ? null : AllTasks.fromMap(json["priority0"]),
    priority1: json["priority1"] == null ? null : AllTasks.fromMap(json["priority1"]),
    priority2: json["priority2"] == null ? null : AllTasks.fromMap(json["priority2"]),
  );

  Map<String, dynamic> toMap() => {
    "allTasks": allTasks == null ? null : allTasks.toMap(),
    "priority0": priority0 == null ? null : priority0.toMap(),
    "priority1": priority1 == null ? null : priority1.toMap(),
    "priority2": priority2 == null ? null : priority2.toMap(),
  };
}

class AllTasks {
  int all;
  int done;

  AllTasks({
    this.all,
    this.done,
  });

  factory AllTasks.fromJson(String str) => AllTasks.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AllTasks.fromMap(Map<String, dynamic> json) => AllTasks(
    all: json["all"] == null ? null : json["all"],
    done: json["done"] == null ? null : json["done"],
  );

  Map<String, dynamic> toMap() => {
    "all": all == null ? null : all,
    "done": done == null ? null : done,
  };
}
