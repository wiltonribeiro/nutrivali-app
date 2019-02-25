import 'package:app/models/Article.dart';
import 'package:http/http.dart' as http;
import 'package:app/config/Environment.dart';
import 'dart:convert';

class NewsController {

  static final NewsController _newsController = new NewsController._internal();
  List<Article> _news;
  int page = 1;

  factory NewsController() {
    return _newsController;
  }

  NewsController._internal(){
    _news = new List();
  }

  bool isAlreadyBeenCalled() {
    return _news.length > 0 ;
  }

  List<Article> getNews() {
    return _news;
  }

  Future<List<Article>> requestNews(String lang) async {

    var response = await http.get("${Environment.urlAPI}/news/$lang/$page");
    if(response.statusCode == 200) {
      List responseJson = json.decode(response.body);
      _news.addAll(responseJson.map((m) => Article.fromJson(m)).toList());
    }

    page++;

    return _news;
  }

}