// To parse this JSON data, do
//
//     final getAllSongsRequest = getAllSongsRequestFromJson(jsonString);

import 'dart:convert';

GetAllSongsRequest getAllSongsRequestFromJson(String str) => GetAllSongsRequest.fromJson(json.decode(str));

String getAllSongsRequestToJson(GetAllSongsRequest data) => json.encode(data.toJson());

class GetAllSongsRequest {
  GetAllSongsRequest({
    this.allTracks,
  });

  AllTracks allTracks;

  factory GetAllSongsRequest.fromJson(Map<String, dynamic> json) => GetAllSongsRequest(
    allTracks: AllTracks.fromJson(json["allTracks"]),
  );

  Map<String, dynamic> toJson() => {
    "allTracks": allTracks.toJson(),
  };
}

class AllTracks {
  AllTracks({
    this.sessionId,
  });

  String sessionId;

  factory AllTracks.fromJson(Map<String, dynamic> json) => AllTracks(
    sessionId: json["session_id"],
  );

  Map<String, dynamic> toJson() => {
    "session_id": sessionId,
  };
}
