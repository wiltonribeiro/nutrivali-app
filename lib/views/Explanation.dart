import 'package:flutter/material.dart';

class Explanation extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(floatingActionButton: new FloatingActionButton(onPressed: (){}, child: Icon(Icons.navigate_next), backgroundColor: Theme.of(context).accentColor, foregroundColor: Colors.white),backgroundColor: Theme.of(context).primaryColor, body: new SingleChildScrollView(child:
      new Container(child:
        new Column(children: <Widget>[
          new Container(constraints: BoxConstraints(minWidth: double.infinity, minHeight: 200, maxHeight: 200), decoration: BoxDecoration(color: Theme.of(context).accentColor, borderRadius: BorderRadius.only(bottomLeft: Radius.elliptical(500, 310))), child:
            new Align(alignment: Alignment.centerRight, child:
              new Padding(padding: EdgeInsets.all(40), child: Image.asset("assets/graphics/logo.png"))
            )
          ),
          new Padding(padding: EdgeInsets.only(bottom: 5, left: 20, right: 40), child:
            new Column(children: <Widget>[
              new Align(child: new Text("Como funciona ?", style: TextStyle(color: Theme.of(context).accentColor, fontSize: 50)), alignment: Alignment.centerLeft),
              new Padding(padding: EdgeInsets.only(top: 20), child:
                new Align(child: new Text("Você já fez compras e guardou um alimento em algum potinho e esqueceu a validade dele ?", style: TextStyle(color: Theme.of(context).primaryColorDark, fontSize: 18)), alignment: Alignment.centerLeft)
              ),
              new Padding(padding: EdgeInsets.only(top: 20), child:
                new Align(child: new Text("Ou comprou um produto baratinho com o prazo perto de vencer mas esqueceu de comer ?", style: TextStyle(color: Theme.of(context).accentColor, fontSize: 18)), alignment: Alignment.centerLeft)
              ),
              new Padding(padding: EdgeInsets.only(top: 20), child:
                new Align(child: new Text("Aqui nós te lembramos até da fruta da feira, que está madura esperando por você.", style: TextStyle(color: Theme.of(context).primaryColorDark, fontSize: 18)), alignment: Alignment.centerLeft)
              ),
            ])
          )
        ])
      )
    ));
  }

}