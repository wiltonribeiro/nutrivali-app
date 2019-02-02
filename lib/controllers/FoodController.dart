import 'package:app/models/Food.dart';
import 'package:app/controllers/AuthController.dart';
import 'package:http/http.dart' as http;
import 'package:app/config/Environment.dart';
import 'dart:convert';

class FoodController {

  List<Food> _foods;
  static final FoodController _foodController = new FoodController._internal();

  factory FoodController() {
    return _foodController;
  }

  FoodController._internal(){
    _foods = new List();
  }

  Future<List<Food>> getFood() async {
    var uid = await AuthController().getUserId();
    var response = await http.get("${Environment.urlAPI}/foods/user/$uid");
    if(response.statusCode != 404) {
      List responseJson = json.decode(response.body);
      _foods = responseJson.map((m) => new Food.fromJson(m)).toList();
    }
    return _foods;
  }

  Future<bool> addFood(String description, String limitDate) async {
    var uidUser = await AuthController().getUserId();
    var food = new Food(description, limitDate, uidUser);
    var url = "${Environment.urlAPI}/foods";

    var response = await http.post(url, body: jsonEncode(food.toJSON()), headers: {"Accept": "application/json", "content-type": "application/json"});
    if(response.statusCode != 200) return false;
    else return true;
  }

  Future<bool> deleteFood(int i) async {

    return false;
  }

  Future<bool> updateFood(int i) async {
    //TODO
    return false;
  }




}