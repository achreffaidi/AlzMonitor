// To parse this JSON data, do
//
//     final location = locationFromJson(jsonString);

import 'dart:convert';

class Location {
  String latitude;
  String longitude;

  Location({
    this.latitude,
    this.longitude,
  });

  factory Location.fromJson(String str) => Location.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Location.fromMap(Map<String, dynamic> json) => Location(
    latitude: json["latitude"] == null ? null : json["latitude"],
    longitude: json["longitude"] == null ? null : json["longitude"],
  );

  Map<String, dynamic> toMap() => {
    "latitude": latitude == null ? null : latitude,
    "longitude": longitude == null ? null : longitude,
  };
}
