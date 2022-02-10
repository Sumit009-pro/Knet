// To parse this JSON data, do
//
//     final getNewEmailEnterOtpVerifyRequest = getNewEmailEnterOtpVerifyRequestFromJson(jsonString);

import 'dart:convert';

GetNewEmailEnterOtpVerifyRequest getNewEmailEnterOtpVerifyRequestFromJson(
        String str) =>
    GetNewEmailEnterOtpVerifyRequest.fromJson(json.decode(str));

String getNewEmailEnterOtpVerifyRequestToJson(
        GetNewEmailEnterOtpVerifyRequest data) =>
    json.encode(data.toJson());

class GetNewEmailEnterOtpVerifyRequest {
  GetNewEmailEnterOtpVerifyRequest({
    this.verifyOtpEmail,
  });

  DataVerifyOtpEmailNew verifyOtpEmail;

  factory GetNewEmailEnterOtpVerifyRequest.fromJson(
          Map<String, dynamic> json) =>
      GetNewEmailEnterOtpVerifyRequest(
        verifyOtpEmail: DataVerifyOtpEmailNew.fromJson(json["verifyOtpEmail"]),
      );

  Map<String, dynamic> toJson() => {
        "verifyOtpEmail": verifyOtpEmail.toJson(),
      };
}

class DataVerifyOtpEmailNew {
  DataVerifyOtpEmailNew({
    this.newEmail,
    this.sessionId,
    this.otp,
  });

  String newEmail;
  String sessionId;
  String otp;

  factory DataVerifyOtpEmailNew.fromJson(Map<String, dynamic> json) =>
      DataVerifyOtpEmailNew(
        newEmail: json["new_email"],
        sessionId: json["session_id"],
        otp: json["otp"],
      );

  Map<String, dynamic> toJson() => {
        "new_email": newEmail,
        "session_id": sessionId,
        "otp": otp,
      };
}
