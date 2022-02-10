// To parse this JSON data, do
//
//     final getAllPlaylistRequest = getAllPlaylistRequestFromJson(jsonString);

import 'dart:convert';

GetAllPlaylistRequest getAllPlaylistRequestFromJson(String str) => GetAllPlaylistRequest.fromJson(json.decode(str));

String getAllPlaylistRequestToJson(GetAllPlaylistRequest data) => json.encode(data.toJson());

class GetAllPlaylistRequest {
  GetAllPlaylistRequest({
    this.listPlaylists,
  });

  ListPlaylists listPlaylists;

  factory GetAllPlaylistRequest.fromJson(Map<String, dynamic> json) => GetAllPlaylistRequest(
    listPlaylists: ListPlaylists.fromJson(json["listPlaylists"]),
  );

  Map<String, dynamic> toJson() => {
    "listPlaylists": listPlaylists.toJson(),
  };
}

class ListPlaylists {
  ListPlaylists({
    this.sessionId,
  });

  String sessionId;

  factory ListPlaylists.fromJson(Map<String, dynamic> json) => ListPlaylists(
    sessionId: json["session_id"],
  );

  Map<String, dynamic> toJson() => {
    "session_id": sessionId,
  };
}
