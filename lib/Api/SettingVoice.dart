// To parse this JSON data, do
//
//     final voices = voicesFromJson(jsonString);

import 'dart:convert';

class Voices {
  List<Voice> list;

  Voices({
    this.list,
  });

  factory Voices.fromJson(String str) => Voices.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Voices.fromMap(Map<String, dynamic> json) => Voices(
    list: json["list"] == null ? null : List<Voice>.from(json["list"].map((x) => Voice.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "list": list == null ? null : List<dynamic>.from(list.map((x) => x.toMap())),
  };
}

class Voice {
  String name;
  String shortName;
  String gender;
  String locale;
  String sampleRateHertz;
  String voiceType;

  Voice({
    this.name,
    this.shortName,
    this.gender,
    this.locale,
    this.sampleRateHertz,
    this.voiceType,
  });

  factory Voice.fromJson(String str) => Voice.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Voice.fromMap(Map<String, dynamic> json) => Voice(
    name: json["Name"] == null ? null : json["Name"],
    shortName: json["ShortName"] == null ? null : json["ShortName"],
    gender: json["Gender"] == null ? null : json["Gender"],
    locale: json["Locale"] == null ? null : json["Locale"],
    sampleRateHertz: json["SampleRateHertz"] == null ? null : json["SampleRateHertz"],
    voiceType: json["VoiceType"] == null ? null : json["VoiceType"],
  );

  Map<String, dynamic> toMap() => {
    "Name": name == null ? null : name,
    "ShortName": shortName == null ? null : shortName,
    "Gender": gender == null ? null : gender,
    "Locale": locale == null ? null : locale,
    "SampleRateHertz": sampleRateHertz == null ? null : sampleRateHertz,
    "VoiceType": voiceType == null ? null : voiceType,
  };
}
