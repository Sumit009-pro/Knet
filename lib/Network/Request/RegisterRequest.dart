class RegisterRequest {
  Register register;

  RegisterRequest({this.register});

  RegisterRequest.fromJson(Map<String, dynamic> json) {
    register = json['register'] != null
        ? new Register.fromJson(json['register'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.register != null) {
      data['register'] = this.register.toJson();
    }
    return data;
  }
}

class Register {
  String username;
  String email;
  String password;
  String specialOffer;
  String planId;
  String isSubscribedToNewsletters;
  String deviceToken;

  Register(
      {this.username,
      this.email,
      this.password,
      this.specialOffer,
      this.planId,
      this.isSubscribedToNewsletters,
      this.deviceToken});

  Register.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    email = json['email'];
    password = json['password'];
    specialOffer = json['special_offer'];
    planId = json['plan_id'];
    isSubscribedToNewsletters = json['is_subscribed_to_newsletters'];
    deviceToken = json['device_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['email'] = this.email;
    data['password'] = this.password;
    data['special_offer'] = this.specialOffer;
    data['plan_id'] = this.planId;
    data['is_subscribed_to_newsletters'] = this.isSubscribedToNewsletters;
    data['device_token'] = this.deviceToken;
    return data;
  }
}
