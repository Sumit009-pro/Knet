// To parse this JSON data, do
//
//     final addSubscriptionResponse = addSubscriptionResponseFromJson(jsonString);

import 'dart:convert';

AddSubscriptionResponse addSubscriptionResponseFromJson(String str) => AddSubscriptionResponse.fromJson(json.decode(str));

String addSubscriptionResponseToJson(AddSubscriptionResponse data) => json.encode(data.toJson());

class AddSubscriptionResponse {
  AddSubscriptionResponse({
    this.data,
    this.message,
    this.statusCode,
  });

  Data data;
  String message;
  int statusCode;

  factory AddSubscriptionResponse.fromJson(Map<String, dynamic> json) => AddSubscriptionResponse(
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
    this.subscriptionType,
    this.amount,
    this.startDate,
    this.endDate,
    this.id,
  });

  int userId;
  String subscriptionType;
  String amount;
  DateTime startDate;
  DateTime endDate;
  int id;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    userId: json["user_id"],
    subscriptionType: json["subscription_type"],
    amount: json["amount"],
    startDate: DateTime.parse(json["start_date"]),
    endDate: DateTime.parse(json["end_date"]),
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "subscription_type": subscriptionType,
    "amount": amount,
    "start_date": startDate.toIso8601String(),
    "end_date": endDate.toIso8601String(),
    "id": id,
  };
}
