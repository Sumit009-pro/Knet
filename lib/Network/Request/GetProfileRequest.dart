class GetProfileRequest {
  Profile profile;

  GetProfileRequest({this.profile});

  GetProfileRequest.fromJson(Map<String, dynamic> json) {
    profile =
        json['profile'] != null ? new Profile.fromJson(json['profile']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.profile != null) {
      data['profile'] = this.profile.toJson();
    }
    return data;
  }
}

class Profile {
  String id;
  String sessionId;

  Profile({this.id, this.sessionId});

  Profile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sessionId = json['session_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['session_id'] = this.sessionId;
    return data;
  }
}
