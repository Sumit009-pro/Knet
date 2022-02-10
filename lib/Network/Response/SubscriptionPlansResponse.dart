// To parse this JSON data, do
//
//     final subscriptionPlansResponse = subscriptionPlansResponseFromJson(jsonString);

import 'dart:convert';

SubscriptionPlansResponse subscriptionPlansResponseFromJson(String str) => SubscriptionPlansResponse.fromJson(json.decode(str));

String subscriptionPlansResponseToJson(SubscriptionPlansResponse data) => json.encode(data.toJson());

class SubscriptionPlansResponse {
  SubscriptionPlansResponse({
    this.data,
    this.message,
    this.statusCode,
  });

  List<Datum> data;
  String message;
  int statusCode;

  factory SubscriptionPlansResponse.fromJson(Map<String, dynamic> json) => SubscriptionPlansResponse(
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
    this.subscriptionPlan,
    this.amount,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String subscriptionPlan;
  String amount;
  dynamic createdAt;
  DateTime updatedAt;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    subscriptionPlan: json["subscription_plan"],
    amount: json["amount"],
    createdAt: json["created_at"],
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "subscription_plan": subscriptionPlan,
    "amount": amount,
    "created_at": createdAt,
    "updated_at": updatedAt.toIso8601String(),
  };
}
