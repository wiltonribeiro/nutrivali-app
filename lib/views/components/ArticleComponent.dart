import 'package:flutter/material.dart';
import 'package:app/models/Article.dart';
import 'package:app/views/ArticleDetails.dart';
import 'package:flutter/cupertino.dart';

class ArticleComponent extends StatefulWidget {

  final Article _article;
  ArticleComponent(this._article);

  _ArticleComponent createState() => new _ArticleComponent();
}

class _ArticleComponent extends State<ArticleComponent> {

  @override
  Widget build(BuildContext context){

    return new GestureDetector(child:
     new Container(decoration: BoxDecoration(borderRadius: new BorderRadius.all(Radius.circular(5))/*, image: DecorationImage(image: NetworkImage(widget._article.urlToImage), fit: BoxFit.cover)*/), child:
        new Stack(children: <Widget>[

          new ClipRRect(borderRadius: BorderRadius.all(Radius.circular(10)), child:
              new Image.network(
                widget._article.urlToImage,
                fit: BoxFit.cover,
                height: double.infinity,
                width: double.infinity,
                alignment: Alignment.center,
              )
          ),
          new Align(alignment: Alignment.topLeft, child:
            new Padding(padding: EdgeInsets.only(top: 10, left: 10), child:
              new Container(
                decoration: BoxDecoration(
                  borderRadius: new BorderRadius.all(Radius.circular(20)),
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    stops: [0.1, 0.5, 0.7, 0.9],
                    colors: [
                      Color(0xFFff8077),
                      Color(0xFFff8b83),
                      Color(0xFFff9a93),
                      Color(0xFFffa39d),
                    ],
                  )
                ), child: new Padding(padding: EdgeInsets.all(5), child: new Text(widget._article.source.toUpperCase(), style: TextStyle(fontSize: 10),))
              )
            )
          ),
          new Align(alignment: Alignment.bottomLeft, child:
            new Container(decoration: new BoxDecoration(boxShadow: [BoxShadow(color: Colors.black87, blurRadius: 80.0, spreadRadius: 35.0, offset: Offset(10.0, 10.0))]), child:
              new Padding(padding: EdgeInsets.only(bottom: 20, left: 10), child: new Text(widget._article.title, style: TextStyle(color: Colors.white, fontSize: 20)))
            )
          )
        ])
    ), onTap: () {
      Navigator.push(context, new CupertinoPageRoute(builder: (context) => new ArticleDetails(widget._article)));
    });
  }
}