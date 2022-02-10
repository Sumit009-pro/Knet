class LoginRequest {
  Login login;

  LoginRequest({this.login});

  LoginRequest.fromJson(Map<String, dynamic> json) {
    login = json['login'] != null ? new Login.fromJson(json['login']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.login != null) {
      data['login'] = this.login.toJson();
    }
    return data;
  }
}

class Login {
  String email;
  String password;
  String deviceToken;

  Login({this.email, this.password, this.deviceToken});

  Login.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    password = json['password'];
    deviceToken = json['device_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['password'] = this.password;
    data['device_token'] = this.deviceToken;
    return data;
  }
}
