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
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      initialRoute: initScreen == 0 || initScreen == null ? 'onboarding' : 'login',
      routes: {
        'onboarding': (context) => OnboardingScreenOne(),
        'login': (context) => HalamanLogin()
      },
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void startTime() {
    Timer(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacementNamed('onboarding');
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
