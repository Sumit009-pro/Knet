class GetMoreLikeThisRequest {
  VideosGenres videosGenres;

  GetMoreLikeThisRequest({this.videosGenres});

  GetMoreLikeThisRequest.fromJson(dynamic json) {
    videosGenres = json["videosGenres"] != null
        ? VideosGenres.fromJson(json["videosGenres"])
        : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (videosGenres != null) {
      map["videosGenres"] = videosGenres.toJson();
    }
    return map;
  }
}

class VideosGenres {
  String genreId;
  String sessionId;

  VideosGenres({this.genreId, this.sessionId});

  VideosGenres.fromJson(dynamic json) {
    genreId = json["genre_id"];
    sessionId = json["session_id"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["genre_id"] = genreId;
    map["session_id"] = sessionId;
    return map;
  }
}
