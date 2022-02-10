// To parse this JSON data, do
//
//     final updateReviewResponse = updateReviewResponseFromJson(jsonString);

import 'dart:convert';

UpdateReviewResponse updateReviewResponseFromJson(String str) => UpdateReviewResponse.fromJson(json.decode(str));

String updateReviewResponseToJson(UpdateReviewResponse data) => json.encode(data.toJson());

class UpdateReviewResponse {
  UpdateReviewResponse({
    this.data,
    this.message,
    this.statusCode,
  });

  Data data;
  String message;
  int statusCode;

  factory UpdateReviewResponse.fromJson(Map<String, dynamic> json) => UpdateReviewResponse(
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
    this.reviewId,
    this.userId,
    this.sellerId,
    this.review,
    this.rating,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
  });

  int reviewId;
  int userId;
  int sellerId;
  String review;
  String rating;
  String isDeleted;
  DateTime createdAt;
  DateTime updatedAt;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    reviewId: json["review_id"],
    userId: json["user_id"],
    sellerId: json["seller_id"],
    review: json["review"],
    rating: json["rating"],
    isDeleted: json["is_deleted"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "review_id": reviewId,
    "user_id": userId,
    "seller_id": sellerId,
    "review": review,
    "rating": rating,
    "is_deleted": isDeleted,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
