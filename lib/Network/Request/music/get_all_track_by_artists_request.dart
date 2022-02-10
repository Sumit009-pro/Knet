// To parse this JSON data, do
//
//     final getTrackByArtistsRequest = getTrackByArtistsRequestFromJson(jsonString);

import 'dart:convert';

GetTrackByArtistsRequest getTrackByArtistsRequestFromJson(String str) => GetTrackByArtistsRequest.fromJson(json.decode(str));

String getTrackByArtistsRequestToJson(GetTrackByArtistsRequest data) => json.encode(data.toJson());

class GetTrackByArtistsRequest {
  GetTrackByArtistsRequest({
    this.allTracksByArtists,
  });

  AllTracksByArtists allTracksByArtists;

  factory GetTrackByArtistsRequest.fromJson(Map<String, dynamic> json) => GetTrackByArtistsRequest(
    allTracksByArtists: AllTracksByArtists.fromJson(json["allTracksByArtists"]),
  );

  Map<String, dynamic> toJson() => {
    "allTracksByArtists": allTracksByArtists.toJson(),
  };
}

class AllTracksByArtists {
  AllTracksByArtists({
    this.sessionId,
    this.artistId,
  });

  String sessionId;
  int artistId;

  factory AllTracksByArtists.fromJson(Map<String, dynamic> json) => AllTracksByArtists(
    sessionId: json["session_id"],
    artistId: json["artist_id"],
  );

  Map<String, dynamic> toJson() => {
    "session_id": sessionId,
    "artist_id": artistId,
  };
}
