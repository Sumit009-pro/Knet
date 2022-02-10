// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromJson(jsonString);

import 'dart:convert';

LoginResponse loginResponseFromJson(String str) => LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  LoginResponse({
    this.accessToken,
    this.data,
    this.message,
    this.statusCode,
  });

  String accessToken;
  Data data;
  String message;
  int statusCode;

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
    accessToken: json["access_token"],
    data: Data.fromJson(json["data"]),
    message: json["message"],
    statusCode: json["status code"],
  );

  Map<String, dynamic> toJson() => {
    "access_token": accessToken,
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
