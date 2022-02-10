// To parse this JSON data, do
//
//     final allTvRequest = allTvRequestFromJson(jsonString);

import 'dart:convert';

AllTvRequest allTvRequestFromJson(String str) =>
    AllTvRequest.fromJson(json.decode(str));

String allTvRequestToJson(AllTvRequest data) => json.encode(data.toJson());

class AllTvRequest {
  AllTvRequest({
    this.tvshowDashboard,
  });

  TvshowDashboard tvshowDashboard;

  factory AllTvRequest.fromJson(Map<String, dynamic> json) => AllTvRequest(
        tvshowDashboard: json["tvshowDashboard"] == null
            ? null
            : TvshowDashboard.fromJson(json["tvshowDashboard"]),
      );

  Map<String, dynamic> toJson() => {
        "tvshowDashboard":
            tvshowDashboard == null ? null : tvshowDashboard.toJson(),
      };
}

class TvshowDashboard {
  TvshowDashboard({
    this.id,
    this.sessionId,
    this.genresId,
  });

  String id;
  String sessionId;
  int genresId;

  factory TvshowDashboard.fromJson(Map<String, dynamic> json) =>
      TvshowDashboard(
        id: json["id"] == null ? null : json["id"],
        sessionId: json["session_id"] == null ? null : json["session_id"],
        genresId: json["genres_id"] == null ? null : json["genres_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "session_id": sessionId == null ? null : sessionId,
        "genres_id": genresId == null ? null : genresId,
      };
}
