import 'package:flutter/material.dart';
import 'package:app/controllers/FoodController.dart';
import 'package:intl/intl.dart';
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
  List<Food> _userFoods = List();

  @override
  initState(){
    _getFoodData();
    super.initState();
  }

  void _getFoodData() async {
    var response = await FoodController().getFood();
    if(response.length == 0){
      setState(() {
        _foodCount = 0;
        _invalidFoodCount = 0;
        _visibleLoad = true;
        _visibleData = true;
        _nothing = true;
      });
    } else {
      //TODO
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
    }
  }

  void _openBottomSheet(){
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc){
          return new BottomSheetContent((result) => _afterSendingData(result));
    });
  }

  Widget _bottomBar(){

    return new Container(color: Theme.of(context).primaryColorDark, height: 70, child:
      new AnimatedOpacity(opacity: _visibleData ? 1.0 : 0.0, duration: Duration(seconds: 1), child :
        new Container(width: double.infinity, child:
          new Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: <Widget>[
            new Container(width: MediaQuery.of(context).size.width/2, child:
              new Column(mainAxisAlignment: MainAxisAlignment.center,children: <Widget>[
                new Text("$_foodCount", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                new Center(child: new Text("Registrados"))
              ]),
            ),
          new Container(width: MediaQuery.of(context).size.width/2, child:
            new Column(mainAxisAlignment: MainAxisAlignment.center,children: <Widget>[
              new Center(child: new Text("$_invalidFoodCount", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
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
            new Center(child: new Image.asset("assets/graphics/sad.png", width: 120)),
            new Center(child: new Padding(padding: EdgeInsets.only(top: 20), child: new Text("Não há nenhum alimento registrado ainda", style: TextStyle(color: Theme.of(context).accentColor))))
          ])
        );
    }
    else if (_visibleData && _visibleLoad && !_nothing) return new Container();
    else if(!_visibleLoad) return new Center(child: new SizedBox(width: 40, height: 40, child: new CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Theme.of(context).accentColor), strokeWidth: 1)));
    else return new Container();
  }


  Widget build(BuildContext context){
    return Scaffold(bottomNavigationBar: BottomAppBar(child: _bottomBar()), floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked, backgroundColor: Theme.of(context).primaryColor, floatingActionButton: new FloatingActionButton(onPressed: _openBottomSheet, child: Icon(Icons.add, color: Colors.white), backgroundColor: Theme.of(context).accentColor),
        body: new Stack(children: <Widget>[
          new Column(mainAxisSize: MainAxisSize.max, children: <Widget>[
            new Container(width: double.infinity,decoration: BoxDecoration(color: Theme.of(context).accentColor, borderRadius: BorderRadius.only(bottomLeft: Radius.elliptical(120, 80), bottomRight: Radius.elliptical(120, 80))), child:
              new Container(width: double.infinity, margin: EdgeInsets.all(50), child:
                new Center(child:
                  new Column(children: <Widget>[
                    new Text("Olá, tudo bem ?", style: TextStyle(fontSize: 30)),
                  ])
                )
              )
            ),
          ]),
          new Container(margin: EdgeInsets.only(top: 100), child:
            _centerWidgetDecision()
          )
        ])
    );
  }
}

class BottomSheetContent extends StatefulWidget {

  final Function _onRegister;
  BottomSheetContent(this._onRegister);

  _BottomSheetContent createState() => _BottomSheetContent();
}

class _BottomSheetContent extends State<BottomSheetContent> {

  String _dateFormat = new DateFormat('dd/MM/yyyy').format(DateTime.now());
  FoodController _foodController = FoodController();
  TextEditingController _textEditingController = new TextEditingController();

  Future _showDatePicker() async {
    DateTime picked = await showDatePicker(
      context: context,
      initialDate: new DateTime.now(),
      firstDate: new DateTime(2019),
      lastDate: new DateTime(2040),
      locale: Locale("pt", "BR"),
    );


    if(picked != null){
      setState((){
        _dateFormat = new DateFormat('dd/MM/yyyy').format(picked);
      });
    }
  }

  Widget build(BuildContext context){
    var color = Theme.of(context).primaryColorDark;
    return new Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        new Container(margin: EdgeInsets.only(left: 20, top: 20, bottom: 10),child:
        new TextField(
          controller: _textEditingController,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            icon: new Padding(padding: EdgeInsets.only(right: 15), child: new Icon(Icons.text_fields, color: color)),
            labelStyle: new TextStyle(color: color),
            hintStyle: TextStyle(color: Colors.grey),
            focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: color, width: 1)),
            labelText: "Digite a descrição",
            hintText: "Ex: Arroz Ribeiro",
            border: UnderlineInputBorder(),
          ),
          style: TextStyle(fontSize: 18, color: color),
        )
        ),
        new ListTile(
          leading: new Icon(Icons.today, color: color),
          title: new Text('Selecione a data de vencimento', style: TextStyle(color: color)),
          subtitle: new Text("$_dateFormat", style: TextStyle(color: color, fontWeight: FontWeight.bold)),
          onTap: _showDatePicker,
        ),
        new Container(
            margin: EdgeInsets.only(bottom: 20, top: 10),
            width: double.infinity,
            child: new FlatButton(
                padding: EdgeInsets.all(15),
                child: new Text("CADASTRAR".toUpperCase(), style: TextStyle(color: Theme.of(context).accentColor)),
                onPressed:(){
                  if(_textEditingController.text.isNotEmpty){
                     widget._onRegister(_foodController.addFood(_textEditingController.text, _dateFormat));
                     Navigator.pop(context);
                  }
                }
            )
        ),
      ],
    );
  }
}