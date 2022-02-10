// To parse this JSON data, do
//
//     final allUserDetailsResponse = allUserDetailsResponseFromJson(jsonString);

import 'dart:convert';

AllUserDetailsResponse allUserDetailsResponseFromJson(String str) => AllUserDetailsResponse.fromJson(json.decode(str));

String allUserDetailsResponseToJson(AllUserDetailsResponse data) => json.encode(data.toJson());

class AllUserDetailsResponse {
  AllUserDetailsResponse({
    this.data,
    this.message,
    this.statusCode,
  });

  List<Datum> data;
  String message;
  int statusCode;

  factory AllUserDetailsResponse.fromJson(Map<String, dynamic> json) => AllUserDetailsResponse(
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    message: json["message"],
    statusCode: json["status code"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "message": message,
    "status code": statusCode,
  };
}

class Datum {
  Datum({
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
  String username;
  String name;
  dynamic description;
  SellerType sellerType;
  String email;
  String mobile;
  String location;
  String lat;
  String lng;
  dynamic image;
  dynamic emailVerifiedAt;
  String loginType;
  dynamic socialUniqueId;
  String otp;
  DateTime otpCreatedOn;
  DeviceType deviceType;
  dynamic deviceToken;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    username: json["username"] == null ? null : json["username"],
    name: json["name"],
    description: json["description"],
    sellerType: sellerTypeValues.map[json["seller_type"]],
    email: json["email"],
    mobile: json["mobile"],
    location: json["location"] == null ? null : json["location"],
    lat: json["lat"] == null ? null : json["lat"],
    lng: json["lng"] == null ? null : json["lng"],
    image: json["image"],
    emailVerifiedAt: json["email_verified_at"],
    loginType: json["login_type"] == null ? null : json["login_type"],
    socialUniqueId: json["social_unique_id"],
    otp: json["otp"] == null ? null : json["otp"],
    otpCreatedOn: json["otp_created_on"] == null ? null : DateTime.parse(json["otp_created_on"]),
    deviceType: deviceTypeValues.map[json["device_type"]],
    deviceToken: json["device_token"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "username": username == null ? null : username,
    "name": name,
    "description": description,
    "seller_type": sellerTypeValues.reverse[sellerType],
    "email": email,
    "mobile": mobile,
    "location": location == null ? null : location,
    "lat": lat == null ? null : lat,
    "lng": lng == null ? null : lng,
    "image": image,
    "email_verified_at": emailVerifiedAt,
    "login_type": loginType == null ? null : loginType,
    "social_unique_id": socialUniqueId,
    "otp": otp == null ? null : otp,
    "otp_created_on": otpCreatedOn == null ? null : otpCreatedOn.toIso8601String(),
    "device_type": deviceTypeValues.reverse[deviceType],
    "device_token": deviceToken,
  };
}

enum DeviceType { IOS, ANDROID }

final deviceTypeValues = EnumValues({
  "ANDROID": DeviceType.ANDROID,
  "IOS": DeviceType.IOS
});

enum SellerType { INDIVIDUAL }

final sellerTypeValues = EnumValues({
  "Individual": SellerType.INDIVIDUAL
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
