// To parse this JSON data, do
//
//     final updateProfilePictureResponse = updateProfilePictureResponseFromJson(jsonString);

import 'dart:convert';

UpdateProfilePictureResponse updateProfilePictureResponseFromJson(String str) => UpdateProfilePictureResponse.fromJson(json.decode(str));

String updateProfilePictureResponseToJson(UpdateProfilePictureResponse data) => json.encode(data.toJson());

class UpdateProfilePictureResponse {
  UpdateProfilePictureResponse({
    this.data,
    this.message,
    this.statusCode,
  });

  Data data;
  String message;
  int statusCode;

  factory UpdateProfilePictureResponse.fromJson(Map<String, dynamic> json) => UpdateProfilePictureResponse(
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
    this.avatar,
  });

  String avatar;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    avatar: json["avatar"],
  );

  Map<String, dynamic> toJson() => {
    "avatar": avatar,
  };
}
