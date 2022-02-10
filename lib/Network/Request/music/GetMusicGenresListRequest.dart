// To parse this JSON data, do
//
//     final getMusicGenresListRequest = getMusicGenresListRequestFromJson(jsonString);

import 'dart:convert';

GetMusicGenresListRequest getMusicGenresListRequestFromJson(String str) => GetMusicGenresListRequest.fromJson(json.decode(str));

String getMusicGenresListRequestToJson(GetMusicGenresListRequest data) => json.encode(data.toJson());

class GetMusicGenresListRequest {
  GetMusicGenresListRequest({
    this.allMusicGenres,
  });

  AllMusicGenres allMusicGenres;

  factory GetMusicGenresListRequest.fromJson(Map<String, dynamic> json) => GetMusicGenresListRequest(
    allMusicGenres: AllMusicGenres.fromJson(json["AllMusicGenres"]),
  );

  Map<String, dynamic> toJson() => {
    "AllMusicGenres": allMusicGenres.toJson(),
  };
}

class AllMusicGenres {
  AllMusicGenres({
    this.sessionId,
  });

  String sessionId;

  factory AllMusicGenres.fromJson(Map<String, dynamic> json) => AllMusicGenres(
    sessionId: json["session_id"],
  );

  Map<String, dynamic> toJson() => {
    "session_id": sessionId,
  };
}
