// To parse this JSON data, do
//
//     final getTopMusicRequest = getTopMusicRequestFromJson(jsonString);

import 'dart:convert';

GetTopMusicRequest getTopMusicRequestFromJson(String str) => GetTopMusicRequest.fromJson(json.decode(str));

String getTopMusicRequestToJson(GetTopMusicRequest data) => json.encode(data.toJson());

class GetTopMusicRequest {
  GetTopMusicRequest({
    this.getTopMusic,
  });

  GetTopMusic getTopMusic;

  factory GetTopMusicRequest.fromJson(Map<String, dynamic> json) => GetTopMusicRequest(
    getTopMusic: GetTopMusic.fromJson(json["getTopMusic"]),
  );

  Map<String, dynamic> toJson() => {
    "getTopMusic": getTopMusic.toJson(),
  };
}

class GetTopMusic {
  GetTopMusic({
    this.sessionId,
  });

  String sessionId;

  factory GetTopMusic.fromJson(Map<String, dynamic> json) => GetTopMusic(
    sessionId: json["session_id"],
  );

  Map<String, dynamic> toJson() => {
    "session_id": sessionId,
  };
}
