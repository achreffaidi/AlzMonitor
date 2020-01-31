// To parse this JSON data, do
//
//     final addPerson = addPersonFromJson(jsonString);

import 'dart:convert';


class AddPerson {
  List<Person> persons;

  AddPerson({
    this.persons,
  });

  factory AddPerson.fromJson(String str) => AddPerson.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AddPerson.fromMap(Map<String, dynamic> json) => AddPerson(
    persons: json["persons"] == null ? null : List<Person>.from(json["persons"].map((x) => Person.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "persons": persons == null ? null : List<dynamic>.from(persons.map((x) => x.toMap())),
  };
}

class Person {
  String name;
  String id;

  Person({
    this.name,
    this.id,
  });

  factory Person.fromJson(String str) => Person.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Person.fromMap(Map<String, dynamic> json) => Person(
    name: json["name"] == null ? null : json["name"],
    id: json["id"] == null ? null : json["id"],
  );

  Map<String, dynamic> toMap() => {
    "name": name == null ? null : name,
    "id": id == null ? null : id,
  };
}
