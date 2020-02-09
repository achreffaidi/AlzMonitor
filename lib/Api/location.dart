// To parse this JSON data, do
//
//     final location = locationFromJson(jsonString);

import 'dart:convert';

class Location {
  double latitude;
  double longitude;
  int distanceFromSafeZone;
  String message;

  Location({
    this.latitude,
    this.longitude,
    this.distanceFromSafeZone,
    this.message,
  });

  factory Location.fromJson(String str) => Location.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Location.fromMap(Map<String, dynamic> json) => Location(
    latitude: json["latitude"] == null ? null : json["latitude"].toDouble(),
    longitude: json["longitude"] == null ? null : json["longitude"].toDouble(),
    distanceFromSafeZone: json["distanceFromSafeZone"] == null ? null : json["distanceFromSafeZone"],
    message: json["message"] == null ? null : json["message"],
  );

  Map<String, dynamic> toMap() => {
    "latitude": latitude == null ? null : latitude,
    "longitude": longitude == null ? null : longitude,
    "distanceFromSafeZone": distanceFromSafeZone == null ? null : distanceFromSafeZone,
    "message": message == null ? null : message,
  };
}
