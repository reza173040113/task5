import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:task5/views/HalamanHewan.dart';
import 'package:task5/views/HalamanLogin.dart';

import 'HalamanPariwisata.dart';
import 'HalamanProfile.dart';

void main() {
  runApp(new MaterialApp(
    title: "Halaman Utama",
    home: new HalamanHome(),
  ));
}

class HalamanHome extends StatefulWidget {
  StatusLogin statusLogin;
  HalamanHome({this.statusLogin});
  @override
  _HalamanHomeState createState() => _HalamanHomeState();
}

class _HalamanHomeState extends State<HalamanHome> {
  int _selectedIndex = 0;
  List<Widget> _widgetOptions = [];
  
  // [
  //   HalamanPariwisata(),
  //   HalamanHewan(),
  //   HalamanProfile(statusLogin : widget.statusLogin)
  // ];
  //dia ketika logout navbar nya masih ada, brati page login tu masih d dalam scaffoldnya

  @override
  void initState() {
    _widgetOptions = [
    HalamanPariwisata(),
    HalamanHewan(),
    HalamanProfile(statusLogin : widget.statusLogin)
    //gara2 disini kayanya ya kak?
  ];
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        index: 0,
        color: Colors.brown,
        backgroundColor: Colors.white,
        buttonBackgroundColor: Colors.brown,
        height: 50,
        items: <Widget>[
          Icon(
            Icons.menu_book_outlined,
            size: 20,
            color: Colors.white,
          ),
          Icon(Icons.add, size: 20, color: Colors.white),
          Icon(Icons.person, size: 20, color: Colors.white),
        ],
        animationDuration: Duration(milliseconds: 200),
        animationCurve: Curves.bounceInOut,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
      body: _widgetOptions[_selectedIndex],
      backgroundColor: Colors.blueGrey[50],
    );
  }
}
