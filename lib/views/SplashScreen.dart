import 'package:flutter/material.dart';
import 'package:app/controllers/AuthController.dart';
import 'package:flutter/cupertino.dart';
import 'package:app/views/Home.dart';
import 'Explanation.dart';

class SplashScreen extends StatefulWidget {
  _SplashScreen createState() => _SplashScreen();
}

class _SplashScreen extends State<SplashScreen> {

  @override
  initState(){
    _check();
    super.initState();
  }

  void _check() async {
    if(await AuthController().checkUserLogged()){
      Navigator.pushAndRemoveUntil(context, CupertinoPageRoute(builder: (context) => Home()), (Route<dynamic> route) => false);
    }
    else{
      Navigator.pushAndRemoveUntil(context, CupertinoPageRoute(builder: (context) => Explanation()), (Route<dynamic> route) => false);
    }
  }

  @override
  Widget build(BuildContext context){
    return new Scaffold(backgroundColor: Colors.white, body:
      new Center(child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
        new Image.asset("assets/graphics/logo.png", width: 140),
        new Padding(padding: EdgeInsets.only(top: 20), child: new SizedBox(width: 20, height: 20, child: new CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Theme.of(context).accentColor), strokeWidth: 1)))
      ])
    ));
  }
}