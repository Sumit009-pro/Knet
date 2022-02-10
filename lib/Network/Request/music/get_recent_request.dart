// To parse this JSON data, do
//
//     final getRecentRequest = getRecentRequestFromJson(jsonString);

import 'dart:convert';

GetRecentRequest getRecentRequestFromJson(String str) => GetRecentRequest.fromJson(json.decode(str));

String getRecentRequestToJson(GetRecentRequest data) => json.encode(data.toJson());

class GetRecentRequest {
  GetRecentRequest({
    this.getRecentTracks,
  });

  GetRecentTracks getRecentTracks;

  factory GetRecentRequest.fromJson(Map<String, dynamic> json) => GetRecentRequest(
    getRecentTracks: GetRecentTracks.fromJson(json["getRecentTracks"]),
  );

  Map<String, dynamic> toJson() => {
    "getRecentTracks": getRecentTracks.toJson(),
  };
}

class GetRecentTracks {
  GetRecentTracks({
    this.sessionId,
    this.userId,
  });

  String sessionId;
  int userId;

  factory GetRecentTracks.fromJson(Map<String, dynamic> json) => GetRecentTracks(
    sessionId: json["session_id"],
    userId: json["user_id"],
  );

  Map<String, dynamic> toJson() => {
    "session_id": sessionId,
    "user_id": userId,
  };
}
