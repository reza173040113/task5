import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task5/views/HalamanPariwisata.dart';


class HalamanHome extends StatefulWidget {
  // final VoidCallback signOut;
  // HalamanHome(this.signOut);
  @override
  _HalamanHomeState createState() => _HalamanHomeState();
}

class _HalamanHomeState extends State<HalamanHome> {
  //tambahan method signout
  // signOut() async {
  //   setState(() {
  //     widget.signOut();
  //   });
  // }
  Future<List> getData() async {
    final response =
        await http.get("http://192.168.18.4/flutter-server/getBerita.php");
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Halaman Home'),
          backgroundColor: Colors.brown,         
        ),
        body:  Center(
          child: Container(
              color: Color.fromARGB(100, 239,227,212),
              margin: EdgeInsets.only(bottom: 10),
              height: 150,
              child: Expanded(
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return HalamanPariwisata();
                        }));
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 10, left: 10),
                        width: 165,
                        height: 150,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: AssetImage("img/read.png")),
                          border: Border.all(
                            color: Colors.white,
                            width: 5,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              blurRadius: 4,
                              offset: Offset(4, 8), // Shadow position
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        // Navigator.push(context,
                        //     MaterialPageRoute(builder: (context) {
                        //   return HalamanDetailLuarNegeri();
                        // }));
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 10),
                        width: 165,
                        height: 150,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("img/pencil.png")),
                          border: Border.all(
                            color: Colors.white,
                            width: 5,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              blurRadius: 4,
                              offset: Offset(4, 8), // Shadow position
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
        ),);
  }
}
