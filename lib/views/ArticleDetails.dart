import 'package:flutter/material.dart';
import 'package:app/models/Article.dart';
import 'package:app/config/MyLocalizations.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:app/views/WebView.dart';
import 'package:flutter/cupertino.dart';

class ArticleDetails extends StatelessWidget {

  final Article _article;
  ArticleDetails(this._article);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(body: new Container(child:
      new Stack(children: <Widget>[
        new ClipPath(child:
          new Container(height: 300, decoration: BoxDecoration(image: DecorationImage(image: NetworkImage(_article.urlToImage), fit: BoxFit.cover))),
          clipper: BottomWaveClipper()
        ),
        new Padding(padding: EdgeInsets.only(top: 270, left: 10, right: 20), child:
            new SingleChildScrollView(child:
              new Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
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
                    ), child: new Padding(padding: EdgeInsets.all(5), child: new Text(_article.source.toUpperCase(), style: TextStyle(fontSize: 10)))
                ),
                new Padding(padding: EdgeInsets.only(top: 20, bottom: 20, left: 0), child: new Text(_article.title, style: TextStyle(color: Theme.of(context).accentColor, fontSize: 20))),
                new Text(_article.description, style: TextStyle(color: Theme.of(context).primaryColorDark, fontSize: 15)),
                new Column(children: <Widget>[
                  new Container(margin: EdgeInsets.only(top: 30), child:
                    new SizedBox(width: double.infinity,
                      child: new RaisedButton(child: new Text(MyLocalizations.of(context).trans("webView").toUpperCase()), elevation: 5, padding: EdgeInsets.all(10), color: Theme.of(context).accentColor, onPressed: (){
                        Navigator.push(context, CupertinoPageRoute(builder: (context) => new WebView(_article.url)));
                      }, shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20)))),
                    )
                  ),
                  new Container(margin: EdgeInsets.only(top: 5, bottom: 20), child:
                    new SizedBox(width: double.infinity,
                      child: new RaisedButton(child: new Text(MyLocalizations.of(context).trans("visit_url").toUpperCase(), style: TextStyle(color: Theme.of(context).accentColor)), elevation: 5, padding: EdgeInsets.all(10), color: Colors.white, onPressed: (){
                        _launchURL(_article.url);
                      }, shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20)))),
                    )
                  )
                ])
              ])
            )
        )
      ])
    ));
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

}


class BottomWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();

    path.lineTo(0.0, size.height - 60);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0.0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
