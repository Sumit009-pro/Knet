// To parse this JSON data, do
//
//     final addFavoritesRequest = addFavoritesRequestFromJson(jsonString);

import 'dart:convert';

AddFavoritesRequest addFavoritesRequestFromJson(String str) => AddFavoritesRequest.fromJson(json.decode(str));

String addFavoritesRequestToJson(AddFavoritesRequest data) => json.encode(data.toJson());

class AddFavoritesRequest {
  AddFavoritesRequest({
    this.addFavoriteAlbum,
  });

  AddFavoriteAlbum addFavoriteAlbum;

  factory AddFavoritesRequest.fromJson(Map<String, dynamic> json) => AddFavoritesRequest(
    addFavoriteAlbum: AddFavoriteAlbum.fromJson(json["addFavoriteAlbum"]),
  );

  Map<String, dynamic> toJson() => {
    "addFavoriteAlbum": addFavoriteAlbum.toJson(),
  };
}

class AddFavoriteAlbum {
  AddFavoriteAlbum({
    this.sessionId,
    this.userId,
    this.albumId,
  });

  String sessionId;
  int userId;
  int albumId;

  factory AddFavoriteAlbum.fromJson(Map<String, dynamic> json) => AddFavoriteAlbum(
    sessionId: json["session_id"],
    userId: json["user_id"],
    albumId: json["album_id"],
  );

  Map<String, dynamic> toJson() => {
    "session_id": sessionId,
    "user_id": userId,
    "album_id": albumId,
  };
}
