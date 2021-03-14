import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'HalamanHome.dart';
import 'HalamanProfile.dart';
import 'HalamanRegister.dart';
String username='';
enum StatusLogin { signIn, notSignIn }
class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Halaman Login',     
      home: new HalamanLogin(),
     
    );
  }
}
class HalamanLogin extends StatefulWidget {
  @override
  _HalamanLoginState createState() => _HalamanLoginState();
}
//apa bikin yg logout dulu kak? soalnya kalo udah login pasti tetep gituyaudah, mana tombol logout nyaya


class _HalamanLoginState extends State<HalamanLogin> {
  StatusLogin _loginStatus = StatusLogin.notSignIn;
  final _keyForm = GlobalKey<FormState>();
  String nUsername, nPassword;

  checkForm() {
    final form = _keyForm.currentState;
    if (form.validate()) {
      form.save();
      submitDataLogin();
    }
  }

// mengirim request dan menanggapinya
  submitDataLogin() async {
    final responseData =
        await http.post("http://192.168.18.4/flutter-server/login.php", body: {
      "username": nUsername,
      "password": nPassword,
    });
    print(responseData.body);
    final data = jsonDecode(responseData.body);
    int value = data['value'];
    String pesan = data['message'];
    print(data);
    //kok langsung login//buka file login mba//ternyata d php nya
// get data respon
    String dataUsername = data['username'];
    String dataEmail = data['email'];
    String dataAlamat = data['alamat'];
    String dataSex = data['sex'];
    String dataFullname = data['full_name'];
    String dataTanggalDaftar = data['tgl_daftar'];
    String dataIdUser = data['id_user'];
    //di php ny ga di kirim id_user ny, makanya null
    print(dataIdUser);
// cek value 1 atau 0
//nuka d vscode
    if (value == 1) {
      setState(() {
// set status loginnya sebagai login
        _loginStatus = StatusLogin.signIn;
// simpan data ke share preferences
        saveDataPref(value, dataIdUser, dataUsername, dataEmail, dataAlamat,
            dataSex, dataFullname, dataTanggalDaftar);
      });
    } else if (value == 2) {
      print(pesan);
    } else {
      print(pesan);
    }
  }

// method untuk soimpan share pref
  saveDataPref(int value, String dIdUser, dUsername, dEmail, dAlamat, dSex,
      dFullName, dCreated) async {
    Future<SharedPreferences> _sharedPreferences = SharedPreferences.getInstance();
    SharedPreferences sharedPreferences = await _sharedPreferences;
    // setState(() {
      await sharedPreferences.setInt("value", value);
      await sharedPreferences.setString("username", dUsername);
      await sharedPreferences.setString("id_user", dIdUser);
      await sharedPreferences.setString("email", dEmail);
      await sharedPreferences.setString("alamat", dAlamat);
      await sharedPreferences.setString("sex", dSex);
      await sharedPreferences.setString("full_name", dFullName);
      await sharedPreferences.setString("tgl_daftar", dCreated);
    // });
  }

  ///
  /// method ini digunakan untuk mengecek apakah user sudah login atau
//belum
  /// jika sudah set valuenya
  ///
  getDataPref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      int nvalue = sharedPreferences.getInt("value");
      _loginStatus = nvalue == 1 ? StatusLogin.signIn : StatusLogin.notSignIn;
    });
  }

  @override
  void initState() {
    getDataPref();
    super.initState();
  }

//method untuk sign out
  signOUt() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      sharedPreferences.setInt("value", null);
      sharedPreferences.commit();
      _loginStatus = StatusLogin.notSignIn;
    });
  }

  Widget build(BuildContext context) {
    log("Login Status : ${_loginStatus.toString()}");
    switch (_loginStatus) {
      case StatusLogin.notSignIn:
        return Scaffold(
          backgroundColor: Colors.white,
          body: Form(
            key: _keyForm,
            child: ListView(
              children: <Widget>[
                Center(
                  child: Text(
                    'Login Form',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 26.0,
                      color: Colors.brown,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
               
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: TextFormField(
                    validator: (value) {
//cek kalau value nya kosong
                      if (value.isEmpty) {
                        return 'Please Input Username';
                      }
                      return null;
                    },
                    onSaved: (value) => nUsername = value,
                    decoration: InputDecoration(
                        hintText: 'Username',
                        labelText: 'Input Username',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        )),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please Input Password';
                      }
                      return null;
                    },
                    onSaved: (value) => nPassword = value,
                    obscureText: true,
                    decoration: InputDecoration(
                        hintText: 'Password',
                        labelText: 'Input Password',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0))),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(10.0, 40.0, 10.0, 0),
                  child: MaterialButton(
                    color: Colors.blueGrey,
                    textColor: Colors.white,
                    child: Text('Login'),
                    onPressed: () {
                      setState(() {
                        checkForm();
                      });
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 0),
                  child: MaterialButton(
                    textColor: Colors.blueGrey,
                    child: Text('Belum Punya Akun ? Silahkan Daftar'),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HalamanRegister()));
                    },
                  ),
                )
              ],
            ),
          ),
        );
        break;
        //kyk ny masalah d halaman login, ,mungkin status login nya signIn terus, jadi kesini terus
      case StatusLogin.signIn:
        return HalamanHome(statusLogin : _loginStatus);
        break;
    }
  }
}
