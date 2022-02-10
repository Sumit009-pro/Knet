// To parse this JSON data, do
//
//     final dashboardRequest = dashboardRequestFromJson(jsonString);

import 'dart:convert';

DashboardRequest dashboardRequestFromJson(String str) =>
    DashboardRequest.fromJson(json.decode(str));

String dashboardRequestToJson(DashboardRequest data) =>
    json.encode(data.toJson());

class DashboardRequest {
  DashboardRequest({
    this.dashboard,
  });

  Dashboard dashboard;

  factory DashboardRequest.fromJson(Map<String, dynamic> json) =>
      DashboardRequest(
        dashboard: Dashboard.fromJson(json["dashboard"]),
      );

  Map<String, dynamic> toJson() => {
        "dashboard": dashboard.toJson(),
      };
}

class Dashboard {
  Dashboard({
    this.id,
    this.sessionId,
  });

  String id;
  String sessionId;

  factory Dashboard.fromJson(Map<String, dynamic> json) => Dashboard(
        id: json["id"],
        sessionId: json["session_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "session_id": sessionId,
      };
}
