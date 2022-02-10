// To parse this JSON data, do
//
//     final getEpisodedBySeasonIdRequest = getEpisodedBySeasonIdRequestFromJson(jsonString);

import 'dart:convert';

GetEpisodedBySeasonIdRequest getEpisodedBySeasonIdRequestFromJson(String str) =>
    GetEpisodedBySeasonIdRequest.fromJson(json.decode(str));

String getEpisodedBySeasonIdRequestToJson(GetEpisodedBySeasonIdRequest data) =>
    json.encode(data.toJson());

class GetEpisodedBySeasonIdRequest {
  GetEpisodedBySeasonIdRequest({
    this.getEpisodeBySeasonId,
  });

  GetEpisodeBySeasonId getEpisodeBySeasonId;

  factory GetEpisodedBySeasonIdRequest.fromJson(Map<String, dynamic> json) =>
      GetEpisodedBySeasonIdRequest(
        getEpisodeBySeasonId: json["getEpisodeBySeasonId"] == null
            ? null
            : GetEpisodeBySeasonId.fromJson(json["getEpisodeBySeasonId"]),
      );

  Map<String, dynamic> toJson() => {
        "getEpisodeBySeasonId":
            getEpisodeBySeasonId == null ? null : getEpisodeBySeasonId.toJson(),
      };
}

class GetEpisodeBySeasonId {
  GetEpisodeBySeasonId({
    this.seasonId,
    this.contentId,
    this.sessionId,
  });

  int seasonId;
  int contentId;
  String sessionId;

  factory GetEpisodeBySeasonId.fromJson(Map<String, dynamic> json) =>
      GetEpisodeBySeasonId(
        seasonId: json["season_id"] == null ? null : json["season_id"],
        contentId: json["content_id"] == null ? null : json["content_id"],
        sessionId: json["session_id"] == null ? null : json["session_id"],
      );

  Map<String, dynamic> toJson() => {
        "season_id": seasonId == null ? null : seasonId,
        "content_id": contentId == null ? null : contentId,
        "session_id": sessionId == null ? null : sessionId,
      };
}
