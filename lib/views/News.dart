import 'package:flutter/material.dart';
import 'package:app/config/MyLocalizations.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:app/controllers/NewsController.dart';
import 'components/ArticleComponent.dart';

class News extends StatefulWidget {
    _News createState() => new _News();
}

class _News extends State<News> {

  int _current = 0;
  bool _loading = true;
  List _news = new List();
  bool _checkConfiguration() => true;

  @override
  void initState() {
    super.initState();
    if(_checkConfiguration()){
      new Future.delayed(Duration.zero,(){

        if(NewsController().isAlreadyBeenCalled()){
          setState(() {
            _news = NewsController().getNews();
            _loading = false;
          });
        } else {
          var lang = MyLocalizations.of(context).trans("language");
          loadNews(lang);
        }
      });
    }
  }


  void loadNews(String lang) async {

    var response = await new NewsController().requestNews(lang);

    setState(() {
      _news = response;
      _loading = false;
    });

  }

  Widget _loadingContent(){
    return new Center(child: new SizedBox(width: 40, height: 40, child: new CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Theme.of(context).accentColor), strokeWidth: 1)));
  }

  Widget _carouselContent(){
    return new CarouselSlider(
        items: _news.map((item) {
          return new Builder(
            builder: (BuildContext context) {
              return new Container(
                  width: MediaQuery.of(context).size.width,
                  margin: new EdgeInsets.only(left: 15, bottom: 10),
                  child: new ArticleComponent(item)
              );
            },
          );
        }).toList(),
        updateCallback: (index) {

//          if(index == _news.length-3){
//            var lang = MyLocalizations.of(context).trans("language");
//            loadNews(lang);
//          }

          setState(() {
            _current = index;
          });
        },
        reverse: false,
        height: MediaQuery.of(context).size.height,
        autoPlayDuration: Duration(days: 1),
        autoPlay: false
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(body:
      new Stack(children: <Widget>[
          new Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.max, children: <Widget>[
            new Padding(padding: EdgeInsets.only(top: 60, left: 10), child: new Text(MyLocalizations.of(context).trans('news'), style: TextStyle(fontSize: 30, color: Theme.of(context).accentColor))),
            new Padding(padding: EdgeInsets.only(top: 10, left: 10), child: new Text(MyLocalizations.of(context).trans('news_explanation'), style: TextStyle(fontSize: 15, color: Theme.of(context).primaryColorDark)))
          ]),
          new Container(margin: EdgeInsets.only(top: 160), child:
            _loading ? _loadingContent() : _carouselContent()
          )
        ])
    );

  }

}