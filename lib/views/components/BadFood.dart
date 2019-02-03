import 'package:flutter/material.dart';

class BadFood extends StatelessWidget {

  final String _title, _addedDate, _limitDate;
  BadFood(this._title, this._addedDate, this._limitDate);

  Widget build(BuildContext context) {
    return new Container(margin: EdgeInsets.only(left: 10, right: 10, bottom: 20), padding: EdgeInsets.all(20), width: double.infinity, decoration:
      new BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(10)), boxShadow: [new BoxShadow(color: Color(0x42f04400), blurRadius: 2.0, offset: new Offset(0.0, 5.0))]), child:
        new Row(children: <Widget>[
          new Align(alignment: Alignment.center, child: new Image.asset("assets/graphics/trash.png", width: 60, height: 60)),
          new Expanded(child:
              new Padding(padding: EdgeInsets.only(left: 10, right: 10), child:
                new Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
                  new Padding(padding: EdgeInsets.only(bottom: 10), child: new Text("$_title", style: TextStyle(fontSize: 20, color: Color(0xFFf04400)), textAlign: TextAlign.left)),
                  new Padding(padding: EdgeInsets.only(bottom: 5), child: new Text("ADICIONADO: $_addedDate", style: TextStyle(fontSize: 10, color: Theme.of(context).primaryColorDark), textAlign: TextAlign.left)),
                  new Text("VALIDADE: $_limitDate", style: TextStyle(fontSize: 10, color: Theme.of(context).primaryColorDark), textAlign: TextAlign.left),
                ])
              )
          )
        ])
    );
  }

}