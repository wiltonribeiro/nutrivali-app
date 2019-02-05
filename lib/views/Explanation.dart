import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'Home.dart';
import 'package:app/views/components/Tutorial.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Explanation extends StatefulWidget {
  _Explanation createState() => _Explanation();
}

class _Explanation extends State<Explanation> {

  int _current = 0;
  List<Widget> _tutorial = new Tutorial().getTutorial();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(floatingActionButton: new AnimatedOpacity(opacity: _current == 2 ? 1.0 : 0.0, duration: Duration(milliseconds: 200), child:
      new FloatingActionButton(
          onPressed: (){
            Navigator.push(context, CupertinoPageRoute(builder: (context) => Home()));
            }
          ,child: Icon(Icons.check), backgroundColor: Theme.of(context).accentColor, foregroundColor: Colors.white)
      ),backgroundColor: Theme.of(context).primaryColor, body: new SingleChildScrollView(child:
      new Container(height: MediaQuery.of(context).size.height, child:
        new Stack(children: <Widget>[
          new Center(child:
            new CarouselSlider(
                items: _tutorial.map((item) {
                  return new Builder(
                    builder: (BuildContext context) {
                      return new Container(
                          width: MediaQuery.of(context).size.width,
                          margin: new EdgeInsets.symmetric(horizontal: 5.0),
                          child: new Center(child:
                            new AnimatedOpacity(opacity: _tutorial[_current] == item ? 1.0 : 0.0, duration: Duration(milliseconds: 500), child: item)
                          )
                      );
                    },
                  );
                }).toList(),
                updateCallback: (index) {
                  setState(() {
                    _current = index;
                  });
                },
                reverse: false,
                height: MediaQuery.of(context).size.height,
                autoPlayDuration: Duration(days: 1),
                autoPlay: false
            )
          ),
          new Positioned(child:
            new Align(alignment: FractionalOffset.bottomCenter, child:
              new Row(mainAxisAlignment: MainAxisAlignment.center, children: [0,1,2].map((i) =>
                  new Container (width: 8.0, height: 8.0,
                      margin: EdgeInsets.symmetric(vertical: 40.0, horizontal: 2.0),
                      decoration: BoxDecoration(shape: BoxShape.circle, color: _current == i ? Theme.of(context).accentColor : Colors.grey),
                  )).toList()
              )
            )
          )
        ])
      )
    ));
  }
}