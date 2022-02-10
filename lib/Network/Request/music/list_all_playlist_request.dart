// To parse this JSON data, do
//
//     final listAllPlaylistRequest = listAllPlaylistRequestFromJson(jsonString);

import 'dart:convert';

ListAllPlaylistRequest listAllPlaylistRequestFromJson(String str) => ListAllPlaylistRequest.fromJson(json.decode(str));

String listAllPlaylistRequestToJson(ListAllPlaylistRequest data) => json.encode(data.toJson());

class ListAllPlaylistRequest {
  ListAllPlaylistRequest({
    this.listPlaylistsTracks,
  });

  ListPlaylistsTracks listPlaylistsTracks;

  factory ListAllPlaylistRequest.fromJson(Map<String, dynamic> json) => ListAllPlaylistRequest(
    listPlaylistsTracks: ListPlaylistsTracks.fromJson(json["listPlaylistsTracks"]),
  );

  Map<String, dynamic> toJson() => {
    "listPlaylistsTracks": listPlaylistsTracks.toJson(),
  };
}

class ListPlaylistsTracks {
  ListPlaylistsTracks({
    this.sessionId,
    this.userId,
  });

  String sessionId;
  int userId;

  factory ListPlaylistsTracks.fromJson(Map<String, dynamic> json) => ListPlaylistsTracks(
    sessionId: json["session_id"],
    userId: json["user_id"],
  );

  Map<String, dynamic> toJson() => {
    "session_id": sessionId,
    "user_id": userId,
  };
}
