// To parse this JSON data, do
//
//     final getAllArtistsRequest = getAllArtistsRequestFromJson(jsonString);

import 'dart:convert';

GetAllArtistsRequest getAllArtistsRequestFromJson(String str) => GetAllArtistsRequest.fromJson(json.decode(str));

String getAllArtistsRequestToJson(GetAllArtistsRequest data) => json.encode(data.toJson());

class GetAllArtistsRequest {
  GetAllArtistsRequest({
    this.allMusicArtist,
  });

  AllMusicArtist allMusicArtist;

  factory GetAllArtistsRequest.fromJson(Map<String, dynamic> json) => GetAllArtistsRequest(
    allMusicArtist: AllMusicArtist.fromJson(json["AllMusicArtist"]),
  );

  Map<String, dynamic> toJson() => {
    "AllMusicArtist": allMusicArtist.toJson(),
  };
}

class AllMusicArtist {
  AllMusicArtist({
    this.sessionId,
  });

  String sessionId;

  factory AllMusicArtist.fromJson(Map<String, dynamic> json) => AllMusicArtist(
    sessionId: json["session_id"],
  );

  Map<String, dynamic> toJson() => {
    "session_id": sessionId,
  };
}
