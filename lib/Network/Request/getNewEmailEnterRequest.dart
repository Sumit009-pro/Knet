// To parse this JSON data, do
//
//     final getNewEmailEnterRequest = getNewEmailEnterRequestFromJson(jsonString);

import 'dart:convert';

GetNewEmailEnterRequest getNewEmailEnterRequestFromJson(String str) =>
    GetNewEmailEnterRequest.fromJson(json.decode(str));

String getNewEmailEnterRequestToJson(GetNewEmailEnterRequest data) =>
    json.encode(data.toJson());

class GetNewEmailEnterRequest {
  GetNewEmailEnterRequest({
    this.newEmail,
  });

  DataNewEmail newEmail;

  factory GetNewEmailEnterRequest.fromJson(Map<String, dynamic> json) =>
      GetNewEmailEnterRequest(
        newEmail: DataNewEmail.fromJson(json["newEmail"]),
      );

  Map<String, dynamic> toJson() => {
        "newEmail": newEmail.toJson(),
      };
}

class DataNewEmail {
  DataNewEmail({
    this.newEmail,
    this.sessionId,
  });

  String newEmail;
  String sessionId;

  factory DataNewEmail.fromJson(Map<String, dynamic> json) => DataNewEmail(
        newEmail: json["new_email"],
        sessionId: json["session_id"],
      );

  Map<String, dynamic> toJson() => {
        "new_email": newEmail,
        "session_id": sessionId,
      };
}
