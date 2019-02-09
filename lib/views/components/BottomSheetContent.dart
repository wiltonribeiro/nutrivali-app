import 'package:flutter/material.dart';
import 'package:app/controllers/FoodController.dart';
import 'package:intl/intl.dart';
import 'package:app/config/MyLocalizations.dart';

class BottomSheetContent extends StatefulWidget {

  final Function _onRegister;
  final GlobalKey<ScaffoldState> _key;
  BottomSheetContent(this._onRegister, this._key);

  _BottomSheetContent createState() => _BottomSheetContent();
}

class _BottomSheetContent extends State<BottomSheetContent> {

  DateFormat _officialFormat = DateFormat('dd/MM/yyyy');
  String _dateFormat;
  FoodController _foodController = FoodController();
  TextEditingController _textEditingController = new TextEditingController();
  bool _checkConfiguration() => true;

  initState(){
    super.initState();
    if(_checkConfiguration()){
      new Future.delayed(Duration.zero,(){
        setState(() {
          _dateFormat = new DateFormat('${MyLocalizations.of(context).trans("date_format")}').format(DateTime.now());
        });
      });
    }
  }

  Future _showDatePicker(BuildContext _context) async {
    DateTime picked = await showDatePicker(
        context: context,
        initialDate: new DateTime.now(),
        firstDate: new DateTime(2019),
        lastDate: new DateTime(2040),
        locale: Locale(MyLocalizations.of(context).trans("language"),MyLocalizations.of(context).trans("country"))
    );


    if(picked != null){
      setState((){
        _dateFormat = new DateFormat('${MyLocalizations.of(_context).trans("date_format")}').format(picked);
      });
    }
  }

  Widget build(BuildContext context){
    var color = Theme.of(context).primaryColorDark;

    return new Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        new Container(margin: EdgeInsets.only(left: 20, top: 20, bottom: 10),child:
        Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child:
            new TextField(
              controller: _textEditingController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                icon: new Padding(padding: EdgeInsets.only(right: 15), child: new Icon(Icons.text_fields, color: color)),
                labelStyle: new TextStyle(color: color),
                hintStyle: TextStyle(color: Colors.grey),
                focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: color, width: 1)),
                labelText: "${MyLocalizations.of(context).trans("enter_description")}",
                hintText: "Ex: ${MyLocalizations.of(context).trans("food_example")}",
                border: UnderlineInputBorder(),
              ),
              style: TextStyle(fontSize: 18, color: color),
            )
        )),
        new ListTile(
          leading: new Icon(Icons.today, color: color),
          title: new Text("${MyLocalizations.of(context).trans("due_date")}", style: TextStyle(color: color)),
          subtitle: new Text("$_dateFormat", style: TextStyle(color: color, fontWeight: FontWeight.bold)),
          onTap: (){
            _showDatePicker(context);
          },
        ),
        new Container(
            margin: EdgeInsets.only(bottom: 20, top: 10),
            width: double.infinity,
            child: new FlatButton(
                padding: EdgeInsets.all(15),
                child: new Text("${MyLocalizations.of(context).trans("register")}".toUpperCase(), style: TextStyle(color: Theme.of(context).accentColor)),
                onPressed:(){
                  if(_textEditingController.text.isNotEmpty){
                    var test = new DateFormat('${MyLocalizations.of(context).trans("date_format")}').parse(_dateFormat);
                    var result = _foodController.addFood(_textEditingController.text, _officialFormat.format(test));
                    widget._onRegister(result);
                    Navigator.pop(context);
                  } else {
                    Navigator.pop(context);
                    widget._key.currentState.showSnackBar(SnackBar(
                      content: new Text("${MyLocalizations.of(context).trans("food_description")}"),
                      action: SnackBarAction(label: 'OK', onPressed: widget._key.currentState.hideCurrentSnackBar),
                    ));
                  }
                }
            )
        ),
      ],
    );
  }
}