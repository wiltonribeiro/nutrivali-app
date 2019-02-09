

class User {
  String authUid, token, lang;

  User(this.authUid, this.token, this.lang);

  User.fromJson(Map<String, dynamic> json){
    this.authUid = json["auth_uid"];
    this.token = json["token"];
    this.lang = json["lang"];
  }

  Map<String, String> toJSON() => {
    "auth_uid": this.authUid,
    "token": this.token,
    "lang": this.lang
  };

}