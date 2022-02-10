// To parse this JSON data, do
//
//     final addFollowArtistsRequest = addFollowArtistsRequestFromJson(jsonString);

import 'dart:convert';

AddFollowArtistsRequest addFollowArtistsRequestFromJson(String str) => AddFollowArtistsRequest.fromJson(json.decode(str));

String addFollowArtistsRequestToJson(AddFollowArtistsRequest data) => json.encode(data.toJson());

class AddFollowArtistsRequest {
  AddFollowArtistsRequest({
    this.addFollowerArtists,
  });

  AddFollowerArtists addFollowerArtists;

  factory AddFollowArtistsRequest.fromJson(Map<String, dynamic> json) => AddFollowArtistsRequest(
    addFollowerArtists: AddFollowerArtists.fromJson(json["addFollowerArtists"]),
  );

  Map<String, dynamic> toJson() => {
    "addFollowerArtists": addFollowerArtists.toJson(),
  };
}

class AddFollowerArtists {
  AddFollowerArtists({
    this.sessionId,
    this.userId,
    this.artistId,
  });

  String sessionId;
  int userId;
  int artistId;

  factory AddFollowerArtists.fromJson(Map<String, dynamic> json) => AddFollowerArtists(
    sessionId: json["session_id"],
    userId: json["user_id"],
    artistId: json["artist_id"],
  );

  Map<String, dynamic> toJson() => {
    "session_id": sessionId,
    "user_id": userId,
    "artist_id": artistId,
  };
}
