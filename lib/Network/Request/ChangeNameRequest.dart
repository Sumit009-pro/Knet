// To parse this JSON data, do
//
//     final changeNameRequest = changeNameRequestFromJson(jsonString);

import 'dart:convert';

ChangeNameRequest changeNameRequestFromJson(String str) =>
    ChangeNameRequest.fromJson(json.decode(str));

String changeNameRequestToJson(ChangeNameRequest data) =>
    json.encode(data.toJson());

class ChangeNameRequest {
  ChangeNameRequest({
    this.changename,
  });

  DataChangename changename;

  factory ChangeNameRequest.fromJson(Map<String, dynamic> json) =>
      ChangeNameRequest(
        changename: DataChangename.fromJson(json["changename"]),
      );

  Map<String, dynamic> toJson() => {
        "changename": changename.toJson(),
      };
}

class DataChangename {
  DataChangename({
    this.id,
    this.username,
    this.sessionId,
  });

  String id;
  String username;
  String sessionId;

  factory DataChangename.fromJson(Map<String, dynamic> json) => DataChangename(
        id: json["id"],
        username: json["username"],
        sessionId: json["session_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "session_id": sessionId,
      };
}
