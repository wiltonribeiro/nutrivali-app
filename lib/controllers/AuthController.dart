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

  Future<bool> register() async {
    var user = await _auth.signInAnonymously();
    var token = await getUserToken();
    return await registerUserData(user.uid, token);
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
    return !(user == null || user.uid == null);
  }

  Future<String> getUserToken() {
    return MessagingController().getToken();
  }

  Future<bool> registerUserData(String userId, String token) async {
    if (userId == null || userId.isEmpty || token == null || token.isEmpty) return false;
    else {
      var url = "${Environment.urlAPI}/users";
      var user = new User(userId, token);
      var response = await http.post(url, body: jsonEncode(user.toJSON()), headers: {"Accept": "application/json", "content-type": "application/json"});
      if(response.statusCode == 200) return true;
      else {
        print(response.statusCode);
        return false;
      }
    }

  }


}