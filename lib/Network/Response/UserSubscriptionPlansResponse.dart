// To parse this JSON data, do
//
//     final userSubscriptionPlansResponse = userSubscriptionPlansResponseFromJson(jsonString);

import 'dart:convert';

UserSubscriptionPlansResponse userSubscriptionPlansResponseFromJson(String str) => UserSubscriptionPlansResponse.fromJson(json.decode(str));

String userSubscriptionPlansResponseToJson(UserSubscriptionPlansResponse data) => json.encode(data.toJson());

class UserSubscriptionPlansResponse {
  UserSubscriptionPlansResponse({
    this.data,
    this.message,
    this.statusCode,
  });

  Data data;
  String message;
  int statusCode;

  factory UserSubscriptionPlansResponse.fromJson(Map<String, dynamic> json) => UserSubscriptionPlansResponse(
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
    this.userId,
    this.transactionId,
    this.amount,
    this.subscriptionType,
    this.transactionDetails,
    this.startDate,
    this.endDate,
  });

  int id;
  int userId;
  dynamic transactionId;
  String amount;
  String subscriptionType;
  dynamic transactionDetails;
  DateTime startDate;
  DateTime endDate;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    userId: json["user_id"],
    transactionId: json["transaction_id"],
    amount: json["amount"],
    subscriptionType: json["subscription_type"],
    transactionDetails: json["transaction_details"],
    startDate: DateTime.parse(json["start_date"]),
    endDate: DateTime.parse(json["end_date"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "transaction_id": transactionId,
    "amount": amount,
    "subscription_type": subscriptionType,
    "transaction_details": transactionDetails,
    "start_date": "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
    "end_date": "${endDate.year.toString().padLeft(4, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
  };
}
