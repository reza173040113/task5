import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task5/views/HalamanLogin.dart';
import 'package:task5/views/onboarding/screen_one.dart';

import 'SplashScreen.dart';

int initScreen;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  initScreen = await preferences.getInt('initScreen');
  await preferences.setInt('initScreen', 1);
  runApp(MyApp());
  //wifi masih sama?//masih//kan yg lain masih aman juga kak
  //coba main nya satu aja dari sini, bisa ga
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(initScreen : initScreen),
      // initialRoute: initScreen == 0 || initScreen == null ? 'onboarding' : 'login',
      //gara2 belum login kak kalau kata saya, iya tapi saya jg bingung daritadi supaya masuk ke halaman  ogin
      //iya kak sama . tadi apa yg d ubah? tadi seinget saya kaka ubahnya dibagian onboarding saja sama diprofile. 
      // routes: {
      //   'onboarding': (context) => OnboardingScreenOne(),
      //   'login': (context) => HalamanLogin()
      // },
    );
  }
}

// class SplashScreen extends StatefulWidget {
//   @override
//   _SplashScreenState createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   void startTime() {
//     Timer(Duration(seconds: 5), () {
//       Navigator.of(context).pushReplacementNamed('onboarding');
//     });
//   }

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     startTime();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color.fromARGB(255, 58, 58, 59),
//       body: Center(
//         child: Image.asset(
//           "img/logo.png",
//           width: MediaQuery.of(context).size.width * .5,
//         ),
//       ),
//     );
//   }
// }
