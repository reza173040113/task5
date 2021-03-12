import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

import 'HalamanPariwisata.dart';

void main() {
  runApp(new MaterialApp(
    title: "Halaman Utama",
    home: new HalamanHome(),
  ));
}

class HalamanHome extends StatefulWidget {
  @override
  _HalamanHomeState createState() => _HalamanHomeState();
}

class _HalamanHomeState extends State<HalamanHome> {
  int _selectedIndex = 0;
  final _widgetOptions = [
    HalamanPariwisata(),
    HalamanPariwisata(),
    HalamanPariwisata(),
  ];

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
