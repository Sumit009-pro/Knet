// To parse this JSON data, do
//
//     final getAllAlbumsRequest = getAllAlbumsRequestFromJson(jsonString);

import 'dart:convert';

GetAllAlbumsRequest getAllAlbumsRequestFromJson(String str) => GetAllAlbumsRequest.fromJson(json.decode(str));

String getAllAlbumsRequestToJson(GetAllAlbumsRequest data) => json.encode(data.toJson());

class GetAllAlbumsRequest {
  GetAllAlbumsRequest({
    this.allMusicAlbum,
  });

  AllMusicAlbum allMusicAlbum;

  factory GetAllAlbumsRequest.fromJson(Map<String, dynamic> json) => GetAllAlbumsRequest(
    allMusicAlbum: AllMusicAlbum.fromJson(json["AllMusicAlbum"]),
  );

  Map<String, dynamic> toJson() => {
    "AllMusicAlbum": allMusicAlbum.toJson(),
  };
}

class AllMusicAlbum {
  AllMusicAlbum({
    this.sessionId,
  });

  String sessionId;

  factory AllMusicAlbum.fromJson(Map<String, dynamic> json) => AllMusicAlbum(
    sessionId: json["session_id"],
  );

  Map<String, dynamic> toJson() => {
    "session_id": sessionId,
  };
}
