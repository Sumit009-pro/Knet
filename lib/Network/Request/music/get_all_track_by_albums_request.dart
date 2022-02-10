// To parse this JSON data, do
//
//     final getTrackByAlbumsRequest = getTrackByAlbumsRequestFromJson(jsonString);

import 'dart:convert';

GetTrackByAlbumsRequest getTrackByAlbumsRequestFromJson(String str) => GetTrackByAlbumsRequest.fromJson(json.decode(str));

String getTrackByAlbumsRequestToJson(GetTrackByAlbumsRequest data) => json.encode(data.toJson());

class GetTrackByAlbumsRequest {
  GetTrackByAlbumsRequest({
    this.allTracksByAlbums,
  });

  AllTracksByAlbums allTracksByAlbums;

  factory GetTrackByAlbumsRequest.fromJson(Map<String, dynamic> json) => GetTrackByAlbumsRequest(
    allTracksByAlbums: AllTracksByAlbums.fromJson(json["allTracksByAlbums"]),
  );

  Map<String, dynamic> toJson() => {
    "allTracksByAlbums": allTracksByAlbums.toJson(),
  };
}

class AllTracksByAlbums {
  AllTracksByAlbums({
    this.sessionId,
    this.albumId,
  });

  String sessionId;
  int albumId;

  factory AllTracksByAlbums.fromJson(Map<String, dynamic> json) => AllTracksByAlbums(
    sessionId: json["session_id"],
    albumId: json["album_id"],
  );

  Map<String, dynamic> toJson() => {
    "session_id": sessionId,
    "album_id": albumId,
  };
}
