// To parse this JSON data, do
//
//     final requestOtpResponse = requestOtpResponseFromJson(jsonString);

import 'dart:convert';

RequestOtpResponse requestOtpResponseFromJson(String str) => RequestOtpResponse.fromJson(json.decode(str));

String requestOtpResponseToJson(RequestOtpResponse data) => json.encode(data.toJson());

class RequestOtpResponse {
  RequestOtpResponse({
    this.message,
    this.statusCode,
  });

  String message;
  int statusCode;

  factory RequestOtpResponse.fromJson(Map<String, dynamic> json) => RequestOtpResponse(
    message: json["message"],
    statusCode: json["status code"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "status code": statusCode,
  };
}
