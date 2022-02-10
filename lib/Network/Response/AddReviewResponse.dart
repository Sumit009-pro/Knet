// To parse this JSON data, do
//
//     final addReviewResponse = addReviewResponseFromJson(jsonString);

import 'dart:convert';

AddReviewResponse addReviewResponseFromJson(String str) => AddReviewResponse.fromJson(json.decode(str));

String addReviewResponseToJson(AddReviewResponse data) => json.encode(data.toJson());

class AddReviewResponse {
  AddReviewResponse({
    this.data,
    this.message,
    this.statusCode,
  });

  Data data;
  String message;
  int statusCode;

  factory AddReviewResponse.fromJson(Map<String, dynamic> json) => AddReviewResponse(
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
    this.sellerId,
    this.review,
    this.rating,
    this.updatedAt,
    this.createdAt,
    this.reviewId,
  });

  int userId;
  String sellerId;
  String review;
  String rating;
  DateTime updatedAt;
  DateTime createdAt;
  int reviewId;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    userId: json["user_id"],
    sellerId: json["seller_id"],
    review: json["review"],
    rating: json["rating"],
    updatedAt: DateTime.parse(json["updated_at"]),
    createdAt: DateTime.parse(json["created_at"]),
    reviewId: json["review_id"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "seller_id": sellerId,
    "review": review,
    "rating": rating,
    "updated_at": updatedAt.toIso8601String(),
    "created_at": createdAt.toIso8601String(),
    "review_id": reviewId,
  };
}
