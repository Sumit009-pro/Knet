// To parse this JSON data, do
//
//     final deleteReviewResponse = deleteReviewResponseFromJson(jsonString);

import 'dart:convert';

DeleteReviewResponse deleteReviewResponseFromJson(String str) => DeleteReviewResponse.fromJson(json.decode(str));

String deleteReviewResponseToJson(DeleteReviewResponse data) => json.encode(data.toJson());

class DeleteReviewResponse {
  DeleteReviewResponse({
    this.data,
    this.message,
    this.statusCode,
  });

  String data;
  String message;
  int statusCode;

  factory DeleteReviewResponse.fromJson(Map<String, dynamic> json) => DeleteReviewResponse(
    data: json["data"],
    message: json["message"],
    statusCode: json["status code"],
  );

  Map<String, dynamic> toJson() => {
    "data": data,
    "message": message,
    "status code": statusCode,
  };
}
