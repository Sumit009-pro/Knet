// To parse this JSON data, do
//
//     final singleUserDetailsResponse = singleUserDetailsResponseFromJson(jsonString);

import 'dart:convert';

SingleUserDetailsResponse singleUserDetailsResponseFromJson(String str) => SingleUserDetailsResponse.fromJson(json.decode(str));

String singleUserDetailsResponseToJson(SingleUserDetailsResponse data) => json.encode(data.toJson());

class SingleUserDetailsResponse {
  SingleUserDetailsResponse({
    this.data,
    this.message,
    this.statusCode,
  });

  Data data;
  String message;
  int statusCode;

  factory SingleUserDetailsResponse.fromJson(Map<String, dynamic> json) => SingleUserDetailsResponse(
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
    this.id,
    this.name,
    this.description,
    this.mobile,
    this.location,
    this.email,
    this.userId,
    this.startDate,
    this.endDate,
  });

  int id;
  String name;
  String description;
  String mobile;
  String location;
  String email;
  int userId;
  DateTime startDate;
  DateTime endDate;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    mobile: json["mobile"],
    location: json["location"],
    email: json["email"],
    userId: json["user_id"],
    startDate: DateTime.parse(json["start_date"]),
    endDate: DateTime.parse(json["end_date"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "mobile": mobile,
    "location": location,
    "email": email,
    "user_id": userId,
    "start_date": "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
    "end_date": "${endDate.year.toString().padLeft(4, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
  };
}
