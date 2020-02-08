// To parse this JSON data, do
//
//     final deviceState = deviceStateFromJson(jsonString);

import 'dart:convert';

class DeviceState {
  int battery;
  int difference;

  DeviceState({
    this.battery,
    this.difference,
  });

  factory DeviceState.fromJson(String str) => DeviceState.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DeviceState.fromMap(Map<String, dynamic> json) => DeviceState(
    battery: json["battery"] == null ? null : json["battery"],
    difference: json["difference"] == null ? null : json["difference"],
  );

  Map<String, dynamic> toMap() => {
    "battery": battery == null ? null : battery,
    "difference": difference == null ? null : difference,
  };
}
