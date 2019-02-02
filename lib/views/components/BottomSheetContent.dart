import 'package:flutter/material.dart';
import 'package:app/controllers/FoodController.dart';
import 'package:intl/intl.dart';

class BottomSheetContent extends StatefulWidget {

  final Function _onRegister;
  final GlobalKey<ScaffoldState> _key;
  BottomSheetContent(this._onRegister, this._key);

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
                labelText: "Digite a descrição",
                hintText: "Ex: Arroz Ribeiro",
                border: UnderlineInputBorder(),
              ),
              style: TextStyle(fontSize: 18, color: color),
            )
        )),
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
                  } else {
                    Navigator.pop(context);
                    widget._key.currentState.showSnackBar(SnackBar(
                      content: const Text('Descrição do alimento necessário'),
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