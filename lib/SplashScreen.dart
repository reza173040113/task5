import 'dart:async';

import 'package:flutter/material.dart';
import 'package:task5/OnBoardingScreen.dart';



class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void startTime() {
    Timer(Duration(seconds: 3), () {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return OnBoardingScreen();
      }));
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 58, 58, 59),
      body: Center(
        child: Image.asset(
          "img/logo.png",
          width: MediaQuery.of(context).size.width * .5,
        ),
      ),
    );
  }
}
