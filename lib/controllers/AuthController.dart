import 'package:firebase_auth/firebase_auth.dart';
import 'MessagingController.dart';
import 'package:app/models/User.dart';
import 'package:http/http.dart' as http;
import 'package:app/config/Environment.dart';
import 'dart:convert';

class AuthController {

  static final AuthController _authController = new AuthController._internal();
  FirebaseAuth _auth;

  factory AuthController() {
    return _authController;
  }

  AuthController._internal(){
    _auth = FirebaseAuth.instance;
  }

  void _checkToken(String uid, String token) async {
    var response = await http.get("${Environment.urlAPI}/user/$uid");
    if(response.statusCode != 404 && response.statusCode != 500) {
      var j = json.decode(response.body);
      var user = User.fromJson(j);
      if(user.token != token){
        user.token = token;
        _updateToken(user);
      }
    }
  }

  void _updateToken(User user) async {
    var url = "${Environment.urlAPI}/users/update";
    var response = await http.post(url, body: jsonEncode(user.toJSON()), headers: {"Accept": "application/json", "content-type": "application/json"});
    if (response.statusCode != 200) print("updaaaaaate");
  }

  Future<bool> register(String lang) async {
    var user = await _auth.signInAnonymously();
    var token = await getUserToken();
    return await registerUserData(user.uid, token, lang);
  }

  Future<void> logOut() async {
    await _auth.signOut();
  }

  Future<String> getUserId() async {
    var user = await _auth.currentUser();
    return user.uid;
  }

  Future<bool> checkUserLogged() async{
    var user = await _auth.currentUser();
    var token = await getUserToken();
    bool isLogged = !(user == null || user.uid == null);
    if(isLogged) _checkToken(user.uid, token);
    return isLogged;
  }

  Future<String> getUserToken() {
    return MessagingController().getToken();
  }

  Future<bool> registerUserData(String userId, String token, String lang) async {
    if (userId == null || userId.isEmpty || token == null || token.isEmpty) return false;
    else {
      var url = "${Environment.urlAPI}/users";
      var user = new User(userId, token, lang);
      var response = await http.post(url, body: jsonEncode(user.toJSON()), headers: {"Accept": "application/json", "content-type": "application/json"});
      if(response.statusCode == 200) return true;
      else {
        print(response.statusCode);
        return false;
      }
    }
  }


}