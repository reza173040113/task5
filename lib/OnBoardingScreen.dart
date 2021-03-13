import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task5/views/HalamanLogin.dart';
import 'package:task5/views/onboarding/screen_one.dart';

int initScreen;

Future<void> main() async {
   WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  initScreen = await preferences.getInt('initScreen');
  await preferences.setInt('initScreen', 1);
  runApp(OnBoardingScreen());
}

class OnBoardingScreen extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: initScreen == 0 || initScreen == null ? 'onboarding' : 'login',
      home: HalamanLogin(),
      routes: {
        'onboarding': (context) => OnboardingScreenOne(),
        'login': (context) => HalamanLogin()
      },
    );
  }
}

