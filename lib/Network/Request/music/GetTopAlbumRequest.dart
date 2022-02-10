// To parse this JSON data, do
//
//     final getTopAlbumRequest = getTopAlbumRequestFromJson(jsonString);

import 'dart:convert';

GetTopAlbumRequest getTopAlbumRequestFromJson(String str) => GetTopAlbumRequest.fromJson(json.decode(str));

String getTopAlbumRequestToJson(GetTopAlbumRequest data) => json.encode(data.toJson());

class GetTopAlbumRequest {
  GetTopAlbumRequest({
    this.getTopAlbum,
  });

  GetTopAlbum getTopAlbum;

  factory GetTopAlbumRequest.fromJson(Map<String, dynamic> json) => GetTopAlbumRequest(
    getTopAlbum: GetTopAlbum.fromJson(json["getTopAlbum"]),
  );

  Map<String, dynamic> toJson() => {
    "getTopAlbum": getTopAlbum.toJson(),
  };
}

class GetTopAlbum {
  GetTopAlbum({
    this.sessionId,
  });

  String sessionId;

  factory GetTopAlbum.fromJson(Map<String, dynamic> json) => GetTopAlbum(
    sessionId: json["session_id"],
  );

  Map<String, dynamic> toJson() => {
    "session_id": sessionId,
  };
}
