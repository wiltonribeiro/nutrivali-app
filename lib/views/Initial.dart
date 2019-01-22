import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'Explanation.dart';

class Initial extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return new Scaffold(backgroundColor: Theme.of(context).accentColor, body: Container(child:
      new Center(child:
        new Column(children: <Widget>[
            new Padding(padding: EdgeInsets.only(top: 60, bottom: 10), child: new Text("APP NAME")),
            new Align(alignment: Alignment.centerRight, child:
              new Container(padding: EdgeInsets.only(right: 10, top: 30, left: 40),
                  child: Column(children: <Widget>[
                    new Text("\"A saúde não está na forma física, mas na forma de se alimentar\"", style: TextStyle(fontSize: 20), textAlign: TextAlign.right),
                    new Padding(padding: EdgeInsets.only(top: 10), child: new Align(alignment: Alignment.centerRight, child: new Text("Fábio Ibrahim El Khoury", style: TextStyle(fontSize: 13, fontFamily: 'CrimsonText'))))
                  ])
              )
            ),
            new Expanded(child:
              new Stack(children: <Widget>[
//                new Container(decoration: BoxDecoration(color: Theme.of(context).primaryColor, borderRadius: BorderRadius.only(topRight: Radius.elliptical(750, 280)))),
                new Container(decoration: BoxDecoration(color: Theme.of(context).primaryColor, borderRadius: BorderRadius.only(topRight: Radius.elliptical(650, 300)))),
                new Padding(padding: EdgeInsets.only(top: 50, left: 30, right: 30), child:
                  new Column(children: <Widget>[
                    new Padding(padding: EdgeInsets.only(bottom: 10), child: new Center(child: new Image.asset("assets/graphics/logo.png", width: 140))),
                    new Text("Garanta a qualidade dos seus alimentos guardados em potinhos", textAlign: TextAlign.center, style: TextStyle(color: Theme.of(context).accentColor, fontSize: 20)),
                    new Padding(padding: EdgeInsets.only(top: 40), child:
                      new SizedBox(
                        width: double.infinity,
                        child: new RaisedButton(child: new Text("iniciar".toUpperCase()), padding: EdgeInsets.all(20), color: Theme.of(context).accentColor, onPressed: (){
                          Navigator.push(context, CupertinoPageRoute(builder: (context) => Explanation()));
                        }, shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20)))),
                      )
                    )
                  ])
                )
              ])
            ),
        ])
      )
    ));
  }

}