class GetAllSubscriptionsRequest {
  Subscriptions subscriptions;

  GetAllSubscriptionsRequest({this.subscriptions});

  GetAllSubscriptionsRequest.fromJson(Map<String, dynamic> json) {
    subscriptions = json['subscriptions'] != null
        ? new Subscriptions.fromJson(json['subscriptions'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.subscriptions != null) {
      data['subscriptions'] = this.subscriptions.toJson();
    }
    return data;
  }
}

class Subscriptions {
  String sessionId;

  Subscriptions({this.sessionId});

  Subscriptions.fromJson(Map<String, dynamic> json) {
    sessionId = json['session_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['session_id'] = this.sessionId;
    return data;
  }
}
