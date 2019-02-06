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
  final _key = new GlobalKey<ScaffoldState>();

  @override
  initState(){
    _getFoodData();
    super.initState();
  }

  void _getFoodData() async {
    var response = await FoodController().requestFoods();
    if(response["code"] == 404 || response["code"] == 200) _reloadList();
  }

  void _reloadList(){
    if(FoodController().getFoods().length == 0){
      setState(() {
        _visibleLoad = true;
        _visibleData = true;
        _nothing = true;
      });
    } else {
      setState(() {
        _visibleLoad = true;
        _visibleData = true;
        _nothing = false;
      });
    }
  }

  void _turnLoadOn(){
    setState(() {
      _visibleLoad = false;
      _nothing = false;
    });
  }

  void _turnErrorOn(){
    _key.currentState.showSnackBar(SnackBar(content: const Text('Erro'), action: SnackBarAction(label: 'OK', onPressed: _key.currentState.hideCurrentSnackBar)));
    _reloadList();
  }

  void _afterSendingData(Future<Map> result) async {

    _turnLoadOn();

    var _result = await result;
    bool _response = _result["response"];
    Food _data = _result["data"];

    if(_response){
      FoodController().getFoods().add(_data);
      _reloadList();
    } else _turnErrorOn();
  }

  void _afterDeleting(Future<Map> result) async {

    _turnLoadOn();

    var _result = await result;
    bool _response = _result["response"];
    Food _data = _result["data"];

    if(_response){
      FoodController().getFoods().remove(_data);
      _reloadList();
    } else _turnErrorOn();
  }

  void _openBottomSheet(){
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc){
          return new BottomSheetContent((result) => _afterSendingData(result), _key);
    });
  }

//  Widget _bottomBar(){
//    return new Container(decoration: BoxDecoration(color: Theme.of(context).accentColor, borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))), height: 50, child:
//      new AnimatedOpacity(opacity: _visibleData ? 1.0 : 0.0, duration: Duration(seconds: 1), child :
//        new Container(width: double.infinity, child:
//          new Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: <Widget>[
//            new Container(width: MediaQuery.of(context).size.width/2, child:
//              new Column(mainAxisAlignment: MainAxisAlignment.center,children: <Widget>[
//                new Text("$_foodCount", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
//                new Center(child: new Text("Registrados"))
//              ]),
//            ),
//          new Container(width: MediaQuery.of(context).size.width/2, child:
//            new Column(mainAxisAlignment: MainAxisAlignment.center,children: <Widget>[
//              new Center(child: new Text("$_invalidFoodCount", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold))),
//              new Center(child: new Text("Fora de Validade"))
//            ]),
//          )
//          ])
//        )
//      )
//    );
//  }


  Widget _centerWidgetDecision(){
    if(_nothing){
      return
        new AnimatedOpacity(opacity: _nothing ? 1.0 : 0.0, duration: Duration(seconds: 4), child :
          new Column(mainAxisAlignment: MainAxisAlignment.center,children: <Widget>[
            new Center(child: new Image.asset("assets/graphics/question.png", width: 100)),
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
                _showDialog(FoodController().getFoods()[index]);
              }
            );
          },
          itemCount: FoodController().getFoods().length);
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
              new FlatButton(onPressed: (){
                var response = FoodController().deleteFood(f);
                _afterDeleting(response);
                Navigator.pop(context);
              }, child: new Text("excluir".toUpperCase(), style: TextStyle(color: Colors.red))),
              new FlatButton(onPressed: () => Navigator.pop(context), child: new Text("cancelar".toUpperCase(), style: TextStyle(color: Colors.grey))),
            ],
          ),
        );
      }
    );
  }


  Widget build(BuildContext context){
    return Scaffold(key: _key, floatingActionButton: new FloatingActionButton(onPressed: _openBottomSheet, child: Icon(Icons.add, color: Colors.white), elevation: 5, backgroundColor: Theme.of(context).accentColor),
        body: new Stack(children: <Widget>[
          new Column(mainAxisSize: MainAxisSize.max, children: <Widget>[
            new Padding(padding: EdgeInsets.only(top: 60, left: 20), child: new Text("Que a alimentação seja seu único remédio", textAlign: TextAlign.left, style: TextStyle(fontSize: 30, color: Theme.of(context).accentColor)))
          ]),
          new Container(margin: EdgeInsets.only(top: 160), child:
            _centerWidgetDecision()
          )
        ])
    );
  }
}
