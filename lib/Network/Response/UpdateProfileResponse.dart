// To parse this JSON data, do
//
//     final updateProfileResponse = updateProfileResponseFromJson(jsonString);

import 'dart:convert';

UpdateProfileResponse updateProfileResponseFromJson(String str) => UpdateProfileResponse.fromJson(json.decode(str));

String updateProfileResponseToJson(UpdateProfileResponse data) => json.encode(data.toJson());

class UpdateProfileResponse {
  UpdateProfileResponse({
    this.data,
    this.message,
    this.statusCode,
  });

  Data data;
  String message;
  int statusCode;

  factory UpdateProfileResponse.fromJson(Map<String, dynamic> json) => UpdateProfileResponse(
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
    this.username,
    this.name,
    this.description,
    this.sellerType,
    this.email,
    this.mobile,
    this.location,
    this.lat,
    this.lng,
    this.image,
    this.emailVerifiedAt,
    this.loginType,
    this.socialUniqueId,
    this.otp,
    this.otpCreatedOn,
    this.deviceType,
    this.deviceToken,
  });

  int id;
  dynamic username;
  String name;
  String description;
  String sellerType;
  String email;
  String mobile;
  String location;
  dynamic lat;
  dynamic lng;
  String image;
  dynamic emailVerifiedAt;
  dynamic loginType;
  dynamic socialUniqueId;
  dynamic otp;
  dynamic otpCreatedOn;
  String deviceType;
  String deviceToken;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    username: json["username"],
    name: json["name"],
    description: json["description"],
    sellerType: json["seller_type"],
    email: json["email"],
    mobile: json["mobile"],
    location: json["location"],
    lat: json["lat"],
    lng: json["lng"],
    image: json["image"],
    emailVerifiedAt: json["email_verified_at"],
    loginType: json["login_type"],
    socialUniqueId: json["social_unique_id"],
    otp: json["otp"],
    otpCreatedOn: json["otp_created_on"],
    deviceType: json["device_type"],
    deviceToken: json["device_token"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "username": username,
    "name": name,
    "description": description,
    "seller_type": sellerType,
    "email": email,
    "mobile": mobile,
    "location": location,
    "lat": lat,
    "lng": lng,
    "image": image,
    "email_verified_at": emailVerifiedAt,
    "login_type": loginType,
    "social_unique_id": socialUniqueId,
    "otp": otp,
    "otp_created_on": otpCreatedOn,
    "device_type": deviceType,
    "device_token": deviceToken,
  };
}
