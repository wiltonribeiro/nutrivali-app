import 'package:flutter/material.dart';
import 'package:app/controllers/FoodController.dart';
import 'components/BottomSheetContent.dart';
import 'package:app/models/Food.dart';

class Home extends StatefulWidget {
  _Home createState() => new _Home();
}

class _Home extends State<Home> {

  bool _visibleLoad = false;
  bool _visibleData = false;
  bool _nothing = false;
  int _foodCount;
  int _invalidFoodCount;
  List<Food> _foods = List();
  final _key = new GlobalKey<ScaffoldState>();

  @override
  initState(){
    _getFoodData();
    super.initState();
  }

  void _getFoodData() async {
    var response = await FoodController().getFoods();
    _foods = response;

    if(response.length == 0){
      setState(() {
        _foodCount = 0;
        _invalidFoodCount = 0;
        _visibleLoad = true;
        _visibleData = true;
        _nothing = true;
      });
    } else {
      setState(() {
        _foodCount = response.length;
        _invalidFoodCount = 0;
        _visibleLoad = true;
        _visibleData = true;
        _nothing = false;
      });
    }
  }

  void _afterSendingData(Future<bool> result) async {
    setState(() {
      _visibleLoad = false;
      _nothing = false;
    });

    var _result = await result;
    if(_result) {
      _getFoodData();
    } else {
      _key.currentState.showSnackBar(SnackBar(content: const Text('Erro ao enviar'), action: SnackBarAction(label: 'OK', onPressed: _key.currentState.hideCurrentSnackBar)));
    }
  }

  void _openBottomSheet(){
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc){
          return new BottomSheetContent((result) => _afterSendingData(result), _key);
    });
  }

  Widget _bottomBar(){
    return new Container(decoration: BoxDecoration(color: Theme.of(context).accentColor, borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))), height: 50, child:
      new AnimatedOpacity(opacity: _visibleData ? 1.0 : 0.0, duration: Duration(seconds: 1), child :
        new Container(width: double.infinity, child:
          new Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: <Widget>[
            new Container(width: MediaQuery.of(context).size.width/2, child:
              new Column(mainAxisAlignment: MainAxisAlignment.center,children: <Widget>[
                new Text("$_foodCount", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                new Center(child: new Text("Registrados"))
              ]),
            ),
          new Container(width: MediaQuery.of(context).size.width/2, child:
            new Column(mainAxisAlignment: MainAxisAlignment.center,children: <Widget>[
              new Center(child: new Text("$_invalidFoodCount", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold))),
              new Center(child: new Text("Fora de Validade"))
            ]),
          )
          ])
        )
      )
    );
  }


  Widget _centerWidgetDecision(){
    if(_nothing){
      return
        new AnimatedOpacity(opacity: _nothing ? 1.0 : 0.0, duration: Duration(seconds: 4), child :
          new Column(mainAxisAlignment: MainAxisAlignment.center,children: <Widget>[
            new Center(child: new Image.asset("assets/graphics/sad.png", width: 100)),
            new Center(child: new Padding(padding: EdgeInsets.only(top: 20), child: new Text("Não há nenhum alimento registrado ainda", style: TextStyle(color: Theme.of(context).accentColor))))
          ])
        );
    }
    else if (_visibleData && _visibleLoad && !_nothing){
      return new ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              child: FoodController().getViewFood(index),
              onTap: () {
                _showDialog(_foods[index]);
              }
            );
          },
          itemCount: _foods.length);
    }
    else if(!_visibleLoad) return new Center(child: new SizedBox(width: 40, height: 40, child: new CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Theme.of(context).accentColor), strokeWidth: 1)));
    else return new Container();
  }

  void _showDialog(Food f) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Theme(data: Theme.of(context).copyWith(dialogBackgroundColor: Colors.white), child:
          new AlertDialog(shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))), content:
            new Text("Deseja excluir ${f.description} ?", style: TextStyle(color: Theme.of(context).primaryColorDark)),
            actions: <Widget>[
              new FlatButton(onPressed: (){}, child: new Text("excluir".toUpperCase(), style: TextStyle(color: Colors.red))),
              new FlatButton(onPressed: () => Navigator.pop(context), child: new Text("cancelar".toUpperCase(), style: TextStyle(color: Colors.grey))),
            ],
          ),
        );
      }
    );
  }


  Widget build(BuildContext context){
    return Scaffold(bottomNavigationBar: BottomAppBar(child: _bottomBar(), color: Colors.white), key: _key, floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked, floatingActionButton: new FloatingActionButton(onPressed: _openBottomSheet, child: Icon(Icons.add, color: Theme.of(context).accentColor), elevation: 5, backgroundColor: Colors.white),
        body: new Stack(children: <Widget>[
          new Column(mainAxisSize: MainAxisSize.max, children: <Widget>[
            new Container(width: double.infinity,decoration: BoxDecoration(color: Theme.of(context).accentColor, borderRadius: BorderRadius.only(bottomLeft: Radius.elliptical(120, 20), bottomRight: Radius.elliptical(120, 20))), child:
              new Container(width: double.infinity, margin: EdgeInsets.all(25), child:
                new Center(child:
                  new Column(children: <Widget>[
                    new Padding(padding: EdgeInsets.only(top: 20, bottom: 10), child: new Text("\"Que a alimentação seja seu único remédio\"", textAlign: TextAlign.center, style: TextStyle(fontSize: 12)))
                  ])
                )
              )
            ),
          ]),
          new Container(margin: EdgeInsets.only(top: 50), child:
            _centerWidgetDecision()
          )
        ])
    );
  }
}
