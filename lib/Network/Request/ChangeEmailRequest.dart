// To parse this JSON data, do
//
//     final changeEmailRequest = changeEmailRequestFromJson(jsonString);

import 'dart:convert';

ChangeEmailRequest changeEmailRequestFromJson(String str) =>
    ChangeEmailRequest.fromJson(json.decode(str));

String changeEmailRequestToJson(ChangeEmailRequest data) =>
    json.encode(data.toJson());

class ChangeEmailRequest {
  ChangeEmailRequest({
    this.changeEmail,
  });

  DataChangeEmail changeEmail;

  factory ChangeEmailRequest.fromJson(Map<String, dynamic> json) =>
      ChangeEmailRequest(
        changeEmail: DataChangeEmail.fromJson(json["changeEmail"]),
      );

  Map<String, dynamic> toJson() => {
        "changeEmail": changeEmail.toJson(),
      };
}

class DataChangeEmail {
  DataChangeEmail({
    this.id,
    this.email,
    this.sessionId,
  });

  String id;
  String email;
  String sessionId;

  factory DataChangeEmail.fromJson(Map<String, dynamic> json) =>
      DataChangeEmail(
        id: json["id"],
        email: json["email"],
        sessionId: json["session_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "session_id": sessionId,
      };
}
