class GetGenresListRequest {
  GenresList genres;

  GetGenresListRequest({this.genres});

  GetGenresListRequest.fromJson(dynamic json) {
    genres =
        json["genres"] != null ? GenresList.fromJson(json["genres"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (genres != null) {
      map["genres"] = genres.toJson();
    }
    return map;
  }
}

class GenresList {
  String sessionId;

  GenresList({this.sessionId});

  GenresList.fromJson(dynamic json) {
    sessionId = json["session_id"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["session_id"] = sessionId;
    return map;
  }
}
