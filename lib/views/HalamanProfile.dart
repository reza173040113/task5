import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'HalamanLogin.dart';

class HalamanProfile extends StatelessWidget {
  HalamanProfile({this.username});
  final String username;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: new Container(
                margin: EdgeInsets.all(30),
                width: 190.0,
                height: 190.0,
                decoration: new BoxDecoration(
                    shape: BoxShape.circle,
                    image: new DecorationImage(
                        fit: BoxFit.fill,
                        image: new AssetImage("img/logo.png")))),
          ),
          Container(margin: EdgeInsets.all(10), child: Text("Nama $username")),
          Container(margin: EdgeInsets.all(10), child: Text("Email")),
          GestureDetector(
              onTap: () {
                Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return HalamanLogin();
                      }));
              },
              child:
                  Container(margin: EdgeInsets.all(10), child: Text("Logout"))),
        ],
      ),
    );
  }
}
