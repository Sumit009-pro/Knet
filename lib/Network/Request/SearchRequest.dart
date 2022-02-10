// To parse this JSON data, do
//
//     final searchRequest = searchRequestFromJson(jsonString);

import 'dart:convert';

SearchRequest searchRequestFromJson(String str) =>
    SearchRequest.fromJson(json.decode(str));

String searchRequestToJson(SearchRequest data) => json.encode(data.toJson());

class SearchRequest {
  SearchRequest({
    this.search,
  });

  Search search;

  factory SearchRequest.fromJson(Map<String, dynamic> json) => SearchRequest(
        search: json["search"] == null ? null : Search.fromJson(json["search"]),
      );

  Map<String, dynamic> toJson() => {
        "search": search == null ? null : search.toJson(),
      };
}

class Search {
  Search({
    this.sessionId,
    this.search,
  });

  String sessionId;
  String search;

  factory Search.fromJson(Map<String, dynamic> json) => Search(
        sessionId: json["session_id"] == null ? null : json["session_id"],
        search: json["search"] == null ? null : json["search"],
      );

  Map<String, dynamic> toJson() => {
        "session_id": sessionId == null ? null : sessionId,
        "search": search == null ? null : search,
      };
}
