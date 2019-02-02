

class User {
  String authUid, token;

  User(this.authUid, this.token);

  User.fromJson(Map<String, dynamic> json){
    this.authUid = json["auth_uid"];
    this.token = json["token"];
  }

  Map<String, String> toJSON() => {
    "auth_uid": this.authUid,
    "token": this.token,
  };

}