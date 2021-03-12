import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:task5/views/HalamanDetailLuarNegeri.dart';
import 'dart:async';
import 'dart:convert';

import 'HalamanDetailDalamNegeri.dart';

class HalamanPariwisata extends StatefulWidget {
  @override
  _HalamanPariwisataState createState() => _HalamanPariwisataState();
}

class _HalamanPariwisataState extends State<HalamanPariwisata> {
  Future<List> getData() async {
    final response =
        await http.get("http://192.168.18.4/flutter-server/getPariwisata.php");
    if (response.body.isNotEmpty) {
      return json.decode(response.body);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Halaman Pariwisata'),
          backgroundColor: Colors.brown,
        ),
        body: FutureBuilder<List>(
          future: getData(),
          builder: (context, snapshot) {
            if (snapshot.hasError) print(snapshot.error);
            return snapshot.hasData
                ? ItemList(list: snapshot.data)
                : Center(child: CircularProgressIndicator());
          },
        ));
  }
}

class ItemList extends StatelessWidget {
  final List list;
  ItemList({this.list});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              margin: EdgeInsets.all(10),
              child: Text(
                "Destinasi Favourite",
                style: TextStyle(fontWeight: FontWeight.bold,fontSize: 19),
              )),
          Container(
            height: 150,
            child: Expanded(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: list.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.only(right: 10),
                    width: 100,
                    height: 150,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(100, 203, 129, 79),
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
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return DetailBerita(list, index);
                        }));
                      },
                      child: Container(
                        child: Image.network(
                            'http://192.168.18.4/flutter-server/' +
                                list[index]['gambar'],
                            height: 150,
                            fit: BoxFit.fill),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Container(
              margin: EdgeInsets.all(10),
              child: Text("Kategori",
                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 19))),
          Container(
            color: Color.fromARGB(100, 239,227,212),
            margin: EdgeInsets.only(bottom: 10),
            height: 170,
            child: Expanded(
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return HalamanDetailDalamNegeri();
                      }));
                    },
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 10, left: 10),
                          width: 165,
                          height: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(110),
                            image: DecorationImage(
                                fit: BoxFit.fill,
                                image: AssetImage("img/monas.png")),
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
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return HalamanDetailLuarNegeri();
                      }));
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: 10),
                      width: 165,
                      height: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(110),
                        image: DecorationImage(
                            image: AssetImage("img/liberty.png")),
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
          Container(
              margin: EdgeInsets.all(10),
              child: Text("List Data",
                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 19))),
          Expanded(
            child: ListView.builder(
              itemCount: list.length,
              itemBuilder: (context, index) {
                return Container(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return DetailBerita(list, index);
                      }));
                    },
                    child: Card(
                      child: ListTile(
                        title: Text(
                          list[index]['nama'],
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.brown),
                        ),
                        subtitle: Text("Asal : ${list[index]['asal']}"),
                        trailing: Image.network(
                          'http://192.168.18.4/flutter-server/' +
                              list[index]['gambar'],
                          fit: BoxFit.cover,
                          width: 60.0,
                          height: 60.0,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class DetailBerita extends StatelessWidget {
  List list;
  int index;
  DetailBerita(this.list, this.index);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(list[index]['nama']),
        backgroundColor: Colors.brown,
      ),
      body: ListView(
        children: <Widget>[
          Image.network(
              'http://192.168.18.4/flutter-server/' + list[index]['gambar']),
          Container(
            padding: EdgeInsets.all(32.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(bottom: 8.0),
                        child: Text(
                          list[index]['nama'],
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.brown),
                        ),
                      ),
                      Text(list[index]['asal'])
                    ],
                  ),
                ),
                Icon(
                  Icons.star,
                  color: Colors.brown,
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(32.0),
            child: Text(
              list[index]['deskripsi'],
              softWrap: true,
            ),
          )
        ],
      ),
    );
  }
}
