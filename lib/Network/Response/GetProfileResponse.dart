// To parse this JSON data, do
//
//     final getProfileResponse = getProfileResponseFromJson(jsonString);

import 'dart:convert';

GetProfileResponse getProfileResponseFromJson(String str) => GetProfileResponse.fromJson(json.decode(str));

String getProfileResponseToJson(GetProfileResponse data) => json.encode(data.toJson());

class GetProfileResponse {
  GetProfileResponse({
    this.data,
    this.message,
    this.statusCode,
  });

  Data data;
  String message;
  int statusCode;

  factory GetProfileResponse.fromJson(Map<String, dynamic> json) => GetProfileResponse(
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
    this.businessName,
    this.fbAddress,
    this.igAddress
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
  String otp;
  dynamic otpCreatedOn;
  String deviceType;
  String deviceToken;
  String businessName;
  String fbAddress;
  String igAddress;

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
    businessName: json["business_name"],
    fbAddress: json["facebook_address"],
    igAddress: json["instagram_address"]
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
    "business_name": businessName,
    "facebook_address": fbAddress,
    "instagram_address": igAddress
  };
}
