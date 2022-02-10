// To parse this JSON data, do
//
//     final reviewDetailsResponse = reviewDetailsResponseFromJson(jsonString);

import 'dart:convert';

ReviewDetailsResponse reviewDetailsResponseFromJson(String str) => ReviewDetailsResponse.fromJson(json.decode(str));

String reviewDetailsResponseToJson(ReviewDetailsResponse data) => json.encode(data.toJson());

class ReviewDetailsResponse {
  ReviewDetailsResponse({
    this.data,
    this.message,
    this.statusCode,
  });

  List<Datum> data;
  String message;
  int statusCode;

  factory ReviewDetailsResponse.fromJson(Map<String, dynamic> json) => ReviewDetailsResponse(
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
    this.name,
    this.image,
    this.reviewId,
    this.review,
    this.rating,
  });

  int id;
  String name;
  String image;
  int reviewId;
  String review;
  String rating;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    name: json["name"],
    image: json["image"],
    reviewId: json["review_id"],
    review: json["review"],
    rating: json["rating"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": image,
    "review_id": reviewId,
    "review": review,
    "rating": rating,
  };
}

enum Name { ASHU }

final nameValues = EnumValues({
  "Ashu": Name.ASHU
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
