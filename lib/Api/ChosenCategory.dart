// To parse this JSON data, do
//
//     final chosenCategory = chosenCategoryFromJson(jsonString);

import 'dart:convert';

class ChosenCategory {
  List<ChosenCategoriesList> chosenCategoriesList;

  ChosenCategory({
    this.chosenCategoriesList,
  });

  factory ChosenCategory.fromJson(String str) => ChosenCategory.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ChosenCategory.fromMap(Map<String, dynamic> json) => ChosenCategory(
    chosenCategoriesList: json["chosenCategoriesList"] == null ? null : List<ChosenCategoriesList>.from(json["chosenCategoriesList"].map((x) => ChosenCategoriesList.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "chosenCategoriesList": chosenCategoriesList == null ? null : List<dynamic>.from(chosenCategoriesList.map((x) => x.toMap())),
  };
}

class ChosenCategoriesList {
  List<String> labels;
  String id;
  String chosen;
  String category;
  int v;

  ChosenCategoriesList({
    this.labels,
    this.id,
    this.chosen,
    this.category,
    this.v,
  });

  factory ChosenCategoriesList.fromJson(String str) => ChosenCategoriesList.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ChosenCategoriesList.fromMap(Map<String, dynamic> json) => ChosenCategoriesList(
    labels: json["labels"] == null ? null : List<String>.from(json["labels"].map((x) => x)),
    id: json["_id"] == null ? null : json["_id"],
    chosen: json["chosen"] == null ? null : json["chosen"],
    category: json["category"] == null ? null : json["category"],
    v: json["__v"] == null ? null : json["__v"],
  );

  Map<String, dynamic> toMap() => {
    "labels": labels == null ? null : List<dynamic>.from(labels.map((x) => x)),
    "_id": id == null ? null : id,
    "chosen": chosen == null ? null : chosen,
    "category": category == null ? null : category,
    "__v": v == null ? null : v,
  };
}
