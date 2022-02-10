// To parse this JSON data, do
//
//     final logoutResponse = logoutResponseFromJson(jsonString);

import 'dart:convert';

LogoutResponse logoutResponseFromJson(String str) => LogoutResponse.fromJson(json.decode(str));

String logoutResponseToJson(LogoutResponse data) => json.encode(data.toJson());

class LogoutResponse {
  LogoutResponse({
    this.message,
    this.statusCode,
  });

  String message;
  int statusCode;

  factory LogoutResponse.fromJson(Map<String, dynamic> json) => LogoutResponse(
    message: json["message"],
    statusCode: json["status code"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "status code": statusCode,
  };
}
