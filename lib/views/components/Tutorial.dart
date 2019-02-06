import 'package:flutter/material.dart';

class Tutorial {
  List<Widget> getTutorial(){
    var list = [new _TutorialOne(), new _TutorialTwo(), new _TutorialThree()];
    return list;
  }
}

class _TutorialOne extends StatelessWidget {
  Widget build(BuildContext context) {
    return
      new Center(child:
        new Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
          new Text("Olá, tudo bem ?", style: TextStyle(fontSize: 30, color: Theme.of(context).accentColor)),
          new Padding(padding: EdgeInsets.only(top: 10), child:
            new Text("Deslize para cotinuar...", style: TextStyle(color: Theme.of(context).primaryColorDark))
          )
        ])
      );
  }
}

class _TutorialTwo extends StatelessWidget {

  Widget build(BuildContext context) {
    return
      new Center(child:
        new Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
          new Image.asset("assets/graphics/bad.png", width: 140),
          new Padding(padding: EdgeInsets.only(top: 20), child:
            new Text("Já se esqueceu da validade de algum alimento que guardou, ou daquele bolo que estragou porque você não lembrou quando tinha comprado ?".toUpperCase(), style: TextStyle(fontSize: 15, color: Theme.of(context).primaryColorDark), textAlign: TextAlign.center)
          )
        ])
      );
  }

}

class _TutorialThree extends StatelessWidget {

  Widget build(BuildContext context) {
    return
      new Center(child:
        new Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
          new Image.asset("assets/graphics/happy.png", width: 140),
          new Padding(padding: EdgeInsets.only(top: 20), child:
            new Text("O Nutrivale busca prezar pela sua saúde e evitar o desperdício de alimentos. Assim você poderá aproveitar ao máximo uma boa alimentação.".toUpperCase(), style: TextStyle(color: Theme.of(context).primaryColorDark, fontSize: 15), textAlign: TextAlign.center)
          ),
        ])
      );
  }

}

