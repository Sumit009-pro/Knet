// To parse this JSON data, do
//
//     final verifyResponse = verifyResponseFromJson(jsonString);

import 'dart:convert';

VerifyResponse verifyResponseFromJson(String str) => VerifyResponse.fromJson(json.decode(str));

String verifyResponseToJson(VerifyResponse data) => json.encode(data.toJson());

class VerifyResponse {
  VerifyResponse({
    this.data,
    this.message,
    this.statusCode,
  });

  Data data;
  String message;
  int statusCode;

  factory VerifyResponse.fromJson(Map<String, dynamic> json) => VerifyResponse(
    data: Data.fromJson(json["data"]),
    message: json["message"],
    statusCode: json["status code"],
  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
    "message": message,
    "status code": statusCode,
  };
}

class Data {
  Data({
    this.userId,
  });

  int userId;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    userId: json["user_id"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
  };
}
