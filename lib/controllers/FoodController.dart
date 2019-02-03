import 'package:app/models/Food.dart';
import 'package:app/controllers/AuthController.dart';
import 'package:http/http.dart' as http;
import 'package:app/config/Environment.dart';
import 'package:app/views/components/GoodFood.dart';
import 'package:intl/intl.dart';
import 'package:app/views/components/BadFood.dart';
import 'dart:convert';
import 'package:flutter/material.dart';

class FoodController {

  List<Food> _foods;
  var _format = new DateFormat('dd/MM/yyyy');
  static final FoodController _foodController = new FoodController._internal();

  factory FoodController() {
    return _foodController;
  }

  FoodController._internal(){
    _foods = new List();
  }

  Future<List<Food>> getFoods() async {
    var uid = await AuthController().getUserId();
    var response = await http.get("${Environment.urlAPI}/foods/user/$uid");
    if(response.statusCode != 404) {
      List responseJson = json.decode(response.body);
      _foods = responseJson.map((m) => new Food.fromJson(m)).toList();
      _sortFoods();
    }
    return _foods;
  }

  void _sortFoods(){
    _foods.sort((a,b) => _format.parse(a.limitDate).compareTo(_format.parse(b.limitDate)));
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

  Widget getViewFood(int i){
    var f = _foods[i];
    if(_format.parse(f.limitDate).isBefore(DateTime.now()))
        return new BadFood(f.description, f.addedDate, f.limitDate);
    else
      return new GoodFood(f.description, f.addedDate, f.limitDate);
  }

  bool isGood(Food f){
    return _format.parse(f.limitDate).isAfter(DateTime.now());
  }




}