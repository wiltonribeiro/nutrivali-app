import 'package:flutter/material.dart';
import 'package:app/config/MyLocalizations.dart';
import 'package:app/controllers/NewsController.dart';
import 'components/ArticleComponent.dart';

class News extends StatefulWidget {
    _News createState() => new _News();
}

class _News extends State<News> {

  static double positionScroll = 0;
  String lang;
  bool _loading = true;
  ScrollController _scrollController = new ScrollController();
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
          lang = MyLocalizations.of(context).trans("language");
          loadNews(lang);
        }
      });
    }
  }


  void loadNews(String lang) async {

    setState(() {
      _loading = true;
    });

    var response = await new NewsController().requestNews(lang);

    setState(() {
      _news = response;
      _loading = false;
    });

  }
  
  void _loadMore(){
    print("oi");
  }

  Widget _loadingContent(){
    return new Center(child: new SizedBox(width: 40, height: 40, child: new CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Theme.of(context).accentColor), strokeWidth: 1)));
  }

  Widget _carouselContent(){


    _scrollController.addListener(() {
      double maxScroll = _scrollController.position.maxScrollExtent;
      double currentScroll = _scrollController.position.pixels;
      if (maxScroll == currentScroll) {
        positionScroll = maxScroll;
        _loadMore();
      }
    });


    return new Container(height: MediaQuery.of(context).size.height - 20, child:
      new ListView.builder(controller: _scrollController, scrollDirection: Axis.horizontal, itemCount: _news.length, itemBuilder: (context, position) {
          return new Container(
                width: MediaQuery.of(context).size.width - 40,
                margin: new EdgeInsets.only(left: 15, bottom: 10),
                child: new ArticleComponent(_news[position])
          );
      })
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