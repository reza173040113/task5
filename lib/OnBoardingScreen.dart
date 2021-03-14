import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task5/views/HalamanLogin.dart';
import 'package:task5/views/onboarding/screen_one.dart';

// int initScreen;

// Future<void> main() async {
//    WidgetsFlutterBinding.ensureInitialized();
//   SharedPreferences preferences = await SharedPreferences.getInstance();
//   initScreen =  preferences.getInt('initScreen'); 
//   print("initScreen Value : $initScreen");
//   await preferences.setInt('initScreen', 1);
//   runApp(OnBoardingScreen());
// }
//apa onboardingnya dihapus dulu kak?
class OnBoardingScreen extends StatelessWidget {
  int initScreen;
  OnBoardingScreen({this.initScreen});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: initScreen == 0 || initScreen == null ? 'onboarding' : 'login',//ini kan udah balikin ke awal
      home: HalamanLogin(),
      routes: {
        'onboarding': (context) => OnboardingScreenOne(),
        'login': (context) => HalamanLogin()
      },
    );
  }
}

