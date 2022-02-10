// To parse this JSON data, do
//
//     final allMoviesRequest = allMoviesRequestFromJson(jsonString);

import 'dart:convert';

AllMoviesRequest allMoviesRequestFromJson(String str) =>
    AllMoviesRequest.fromJson(json.decode(str));

String allMoviesRequestToJson(AllMoviesRequest data) =>
    json.encode(data.toJson());

class AllMoviesRequest {
  AllMoviesRequest({
    this.movieDashboard,
  });

  MovieDashboard movieDashboard;

  factory AllMoviesRequest.fromJson(Map<String, dynamic> json) =>
      AllMoviesRequest(
        movieDashboard: json["movieDashboard"] == null
            ? null
            : MovieDashboard.fromJson(json["movieDashboard"]),
      );

  Map<String, dynamic> toJson() => {
        "movieDashboard":
            movieDashboard == null ? null : movieDashboard.toJson(),
      };
}

class MovieDashboard {
  MovieDashboard({
    this.id,
    this.sessionId,
    this.genresId,
  });

  String id;
  String sessionId;
  int genresId;

  factory MovieDashboard.fromJson(Map<String, dynamic> json) => MovieDashboard(
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
