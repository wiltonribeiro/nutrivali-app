import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:app/controllers/AuthController.dart';
import 'Home.dart';

class Initial extends StatefulWidget {
  _Initial createState() => _Initial();
}

class _Initial extends State<Initial>{

  bool _loading = true;

  @override
  void initState() {
    _check();
    super.initState();
  }

  void _check() async {
      var result = await AuthController().register();
      if(result) setState(() => _loading = false);
  }

  Widget _initButton() {
    return new SizedBox(
      width: double.infinity,
      child: new RaisedButton(child: new Text("iniciar".toUpperCase()), padding: EdgeInsets.all(20), color: Theme.of(context).accentColor, onPressed: (){
        Navigator.push(context, CupertinoPageRoute(builder: (context) => Home()));
      }, shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20)))),
    );
  }

  Widget _loadingContent(){
    return new Center(child:
      new SizedBox(width: 20, height: 20, child: new CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Theme.of(context).accentColor), strokeWidth: 1,))
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(backgroundColor: Theme.of(context).accentColor, body: Stack(children: <Widget>[
      new Column(children: <Widget>[
        new Padding(padding: EdgeInsets.only(top: 60, bottom: 10), child: new Text("nutrivali".toUpperCase())),
        new Align(alignment: Alignment.centerRight, child:
          new Container(padding: EdgeInsets.only(right: 10, top: 30, left: 40), child:
            new Column(children: <Widget>[
              new Text("\"A saúde não está na forma física, mas na forma de se alimentar\"", style: TextStyle(fontSize: 20), textAlign: TextAlign.right),
              new Padding(padding: EdgeInsets.only(top: 10), child: new Align(alignment: Alignment.centerRight, child: new Text("Fábio Ibrahim El Khoury", style: TextStyle(fontSize: 13, fontFamily: 'CrimsonText'))))
            ])
          )
        ),
      ]),
      new Container(margin: EdgeInsets.only(top: 200),decoration: BoxDecoration(color: Theme.of(context).primaryColor, borderRadius: BorderRadius.only(topRight: Radius.elliptical(650, 300)))),
      new Padding(padding: EdgeInsets.only(top: 200), child:
      new Center(child:
        new Stack(children: <Widget>[
          new SingleChildScrollView(child:
             new Stack(children: <Widget>[
               new Padding(padding: EdgeInsets.only(top: 50, left: 30, right: 30, bottom: 50), child:
               new Column(mainAxisAlignment: MainAxisAlignment.center,
                   crossAxisAlignment: CrossAxisAlignment.center,children: <Widget>[
                     new Padding(padding: EdgeInsets.only(bottom: 10), child: new Center(child: new Image.asset("assets/graphics/logo.png", width: 100))),
                     new Text("Fique atento e garanta a qualidade dos seus alimentos", textAlign: TextAlign.center, style: TextStyle(color: Theme.of(context).accentColor, fontSize: 20)),
                     new Padding(padding: EdgeInsets.only(top: 40), child:
                        _loading ? _loadingContent() : _initButton()
                     )
                   ])
               )
             ])
          )
        ],
        )
      ))
    ]));
  }

}