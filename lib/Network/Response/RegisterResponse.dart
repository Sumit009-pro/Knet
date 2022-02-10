// To parse this JSON data, do
//
//     final registerResponse = registerResponseFromJson(jsonString);

import 'dart:convert';

RegisterResponse registerResponseFromJson(String str) => RegisterResponse.fromJson(json.decode(str));

String registerResponseToJson(RegisterResponse data) => json.encode(data.toJson());

class RegisterResponse {
  RegisterResponse({
    this.data,
    this.accessToken,
    this.message,
    this.statusCode,
  });

  Data data;
  String accessToken;
  String message;
  int statusCode;

  factory RegisterResponse.fromJson(Map<String, dynamic> json) => RegisterResponse(
    data: Data.fromJson(json["data"]),
    accessToken: json["access_token"],
    message: json["message"],
    statusCode: json["status code"],
  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
    "access_token": accessToken,
    "message": message,
    "status code": statusCode,
  };
}

class Data {
  Data({
    this.name,
    this.email,
    this.mobile,
    this.location,
    this.lat,
    this.lng,
    this.deviceType,
    this.id,
  });

  String name;
  String email;
  String mobile;
  String location;
  String lat;
  String lng;
  String deviceType;
  int id;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    name: json["name"],
    email: json["email"],
    mobile: json["mobile"],
    location: json["location"],
    lat: json["lat"],
    lng: json["lng"],
    deviceType: json["device_type"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "email": email,
    "mobile": mobile,
    "location": location,
    "lat": lat,
    "lng": lng,
    "device_type": deviceType,
    "id": id,
  };
}
