import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'HalamanLogin.dart';

Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

class HalamanProfile extends StatefulWidget {
  StatusLogin statusLogin;
  HalamanProfile({this.statusLogin});
  @override
  _HalamanProfileState createState() => _HalamanProfileState();
}

class _HalamanProfileState extends State<HalamanProfile> {
  StatusLogin get statusLoginGetter => widget.statusLogin;
  set statusLoginSetter(value) {
    widget.statusLogin = value;
  }

  Future<List> getData() async {
    final SharedPreferences prefs = await _prefs;

    // log("HAI + ${prefs.getString('fullname')}");
    //kok jadi bisa kak? kmrin udah dicoba kaya gitu prasaan :v//hehehe ntahlah, itulah ngoding wkwkw///aduhhh
    String id_user = prefs.getString(
        "id_user"); //mungkn  kemarin kita ngantuk//wwkwk mungkin kakhaha
    //value kan bkn ny int tadi
    log("Hai $id_user");
    // selain id ni ada lagi nggak? mbak udah ngantik blum?
    //mksd saya masalah selain id ni
    //oh tinggal sama logout kak
    //masi mau lanjut nih?sdsd
    //boleh kakok tapi bener ga? emang id ny satu? kan reza3 tadi oh
    //tunggu aku liat contoh shared pref ok kak
    //ke get kak :V
    //sipp
    //oke makasih kakk//oke sama2//udah kan?//boleh satu lagi kak? :v//ape tu//yg on boarding belum one screen only euy \
    //mksd ny gmn
    //kan di tugas harusnya sekali muncul nah yang saya muncul berkali2
    //oh iya mksd nya pas pertama kali buka app aja, pas pertama install iya kak gitu
//error lagi kak :v
//ganti wifi dak tu
//engga kak
//apa gara2 logout tadi blm login lagi atau gimana ya?emg tadi abis logout lngsung bbisa masuk lagi y? nah tadi lupa kak setau saya tadi abis logout trs direstart//apa saya hapus data dulu aja?coba aja
    final response = await http
        .post("http://inisialer.000webhostapp.com/getUserById.php", body: {
      "id_user":
          id_user, //ini kak kalo diganti pake iduser error l,dicoba run a?
      //emang d php nya apa? iduser?ga bisa di restart kak knp ya? dari tadi sore expanded nya katanya eror
      //ya udah bener lah, keanpa harus iduser?
      //kan getnya per id kak
      //yang di body tu, ngikutin param yang d php nya, terus kenapa maunya iduser, d php kan id_user
      //oh itu tadi dari kak yusmi dibantuin tapi masih errorcoba run // dari kak? mksd nya
    });
    log("HALAMAN PROFIL : ${response.body}");
    //saya permisi ke wc dulu ya sory
    //oke kak//kok langsun glogin

    //cek aj response ny pake log dulu
    //udah ada kak?
    //brati mungkin salah shared pref
    //kalau id usernya di set valuenya mah muncul kak
    //kak?hallo?kak???halloo?
    //sory lama ok kak
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    // apa yang eror
    return Scaffold(
      //ini salahnya, ga perlu pake material app lagi, material app cukup satu ja buat navigasi seluruh app
      appBar: new AppBar(
        title: Text("Halaman User"),
        backgroundColor: Colors.brown,
      ),

      body: new FutureBuilder<List>(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? new ItemList(
                  statusLogin: statusLoginGetter,
                  list: snapshot.data,
                )
              : new Center(
                  child: new CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}

class ItemList extends StatefulWidget {
  StatusLogin statusLogin;
  final List list;
  ItemList({this.statusLogin, this.list});

  @override
  _ItemListState createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  StatusLogin get statusLoginGetter => widget.statusLogin;
  set statusLoginSetter(value) {
    widget.statusLogin = value;
  }

  @override
  Widget build(BuildContext context) {
    print("${statusLoginGetter.toString()}");
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 100),
              child: new ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.list == null ? 0 : widget.list.length,
                  itemBuilder: (context, i) {
                    return Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color.fromARGB(100, 203, 129, 79),
                          border: Border.all(
                            color: Colors.white,
                            width: 5,
                          ),
                        ),
                        child: Center(
                            child: Text(
                          widget.list[i]['username'][0],
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 48),
                        )));
                  }),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 10),
            child: Text(
              "Info Pengguna",
              style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: new ListView.builder(
                itemCount: widget.list == null ? 0 : widget.list.length,
                itemBuilder: (context, i) {
                  return new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          margin: EdgeInsets.only(left: 10, top: 10),
                          child: Text(
                            "Username",
                            style: TextStyle(color: Colors.grey[400]),
                          )),
                      Container(
                          margin: EdgeInsets.only(left: 10, top: 10),
                          child: Text(widget.list[i]['username'])),
                      Container(
                          margin: EdgeInsets.only(left: 10, top: 10),
                          child: Text(
                            "Email",
                            style: TextStyle(color: Colors.grey[400]),
                          )),
                      Container(
                          margin: EdgeInsets.only(left: 10, top: 10),
                          child: Text(widget.list[i]['email'])),
                      Container(
                          margin: EdgeInsets.only(left: 10, top: 10),
                          child: Text(
                            "Nama Lengkap",
                            style: TextStyle(color: Colors.grey[400]),
                          )),
                      Container(
                          margin: EdgeInsets.only(left: 10, top: 10),
                          child: Text(widget.list[i]['full_name'])),
                      Container(
                          margin: EdgeInsets.only(left: 10, top: 10),
                          child: Text(
                            "Jenis Kelamin",
                            style: TextStyle(color: Colors.grey[400]),
                          )),
                      Container(
                          margin: EdgeInsets.only(left: 10, top: 10),
                          child: Text(widget.list[i]['sex'])),
                      Container(
                          margin: EdgeInsets.only(left: 10, top: 10),
                          child: Text(
                            "Alamat",
                            style: TextStyle(color: Colors.grey[400]),
                          )),
                      Container(
                          margin: EdgeInsets.only(left: 10, top: 10),
                          child: Text(widget.list[i]['alamat'])),
                      Container(
                          margin: EdgeInsets.only(
                            left: 10,
                          ),
                          child: Text(
                            "Logout",
                            style: TextStyle(color: Colors.grey[400]),
                          )),
                      FlatButton(
                          onPressed: () async {
                            setState(() {
                              statusLoginSetter = StatusLogin.notSignIn;
                            });
                            var session = await _prefs;
                            session.clear();
                            // session.setBool('isOnBoarding',true);
                            await session.setInt('initScreen', 1);
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (context) {
                              return HalamanLogin();
                            }));
                          },
                          child: Text(
                            "Logout " + widget.list[i]['username'],
                            style: TextStyle(color: Colors.blue),
                          ))
                    ],
                  );
                }),
          ),
        ],
      ),
    );
  }
}
