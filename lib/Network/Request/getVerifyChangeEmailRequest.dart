// To parse this JSON data, do
//
//     final getVerifyChangeEmailRequest = getVerifyChangeEmailRequestFromJson(jsonString);

import 'dart:convert';

GetVerifyChangeEmailRequest getVerifyChangeEmailRequestFromJson(String str) =>
    GetVerifyChangeEmailRequest.fromJson(json.decode(str));

String getVerifyChangeEmailRequestToJson(GetVerifyChangeEmailRequest data) =>
    json.encode(data.toJson());

class GetVerifyChangeEmailRequest {
  GetVerifyChangeEmailRequest({
    this.verifyOtpEmail,
  });

  DataVerifyOtpEmail verifyOtpEmail;

  factory GetVerifyChangeEmailRequest.fromJson(Map<String, dynamic> json) =>
      GetVerifyChangeEmailRequest(
        verifyOtpEmail: DataVerifyOtpEmail.fromJson(json["verifyOtpEmail"]),
      );

  Map<String, dynamic> toJson() => {
        "verifyOtpEmail": verifyOtpEmail.toJson(),
      };
}

class DataVerifyOtpEmail {
  DataVerifyOtpEmail({
    this.otp,
    this.email,
    this.sessionId,
  });

  String otp;
  String email;
  String sessionId;

  factory DataVerifyOtpEmail.fromJson(Map<String, dynamic> json) =>
      DataVerifyOtpEmail(
        otp: json["otp"],
        email: json["email"],
        sessionId: json["session_id"],
      );

  Map<String, dynamic> toJson() => {
        "otp": otp,
        "email": email,
        "session_id": sessionId,
      };
}
