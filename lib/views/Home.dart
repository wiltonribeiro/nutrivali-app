import 'package:flutter/material.dart';
import 'FoodManagement.dart';
import 'News.dart';
import 'package:app/config/MyLocalizations.dart';

class Home extends StatefulWidget {
  _Home createState() => new _Home();
}

class _Home extends State<Home> {

  int _selectedIndex = 0;

  final FoodManagement _foodManagement = new FoodManagement();
  final News _news = new News();


  Widget pageChooser() {
    switch (_selectedIndex) {
      case 0:
        return _news;
        break;

      case 1:
        return _foodManagement;
        break;

      default:
        return new Container();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {

    var _selectedColor = Theme.of(context).accentColor;
    var _unselectedColor = Colors.grey;


    return Scaffold(
      body: Container(
        child: pageChooser(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.rss_feed, color: _selectedIndex == 0 ? _selectedColor : _unselectedColor ,), title: Text(MyLocalizations.of(context).trans("news"))),
          BottomNavigationBarItem(icon: Icon(Icons.fastfood, color: _selectedIndex == 1 ? _selectedColor : _unselectedColor), title: Text('Nutrivali')),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }


}
