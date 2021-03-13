import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:task5/views/AddHewan.dart';
import 'package:task5/views/DetailHewan.dart';

class Karnivora extends StatefulWidget {
  @override
  _KarnivoraState createState() => _KarnivoraState();
}

class _KarnivoraState extends State<Karnivora> {
  Future<List> getData() async {
    final response =
        await http.get("http://192.168.18.4/flutter-server/detailKarnivora.php");
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: new AppBar(
          title: Text("Karnivora"),
          backgroundColor: Colors.brown,
        ),
        floatingActionButton: new FloatingActionButton(
            child: new Icon(
              Icons.add,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => AddHewan()));
            }),
        body: new FutureBuilder<List>(
          future: getData(),
          builder: (context, snapshot) {
            if (snapshot.hasError) print(snapshot.error);
            return snapshot.hasData
                ? new ItemList(
                    list: snapshot.data,
                  )
                : new Center(
                    child: new CircularProgressIndicator(),
                  );
          },
        ),
      ),
    );
  }
}

class ItemList extends StatelessWidget {
  final List list;
  ItemList({this.list});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Nama Hewan",
            style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 10),
            height: 150,
            child: Expanded(
              child: new ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: list == null ? 0 : list.length,
                  itemBuilder: (context, i) {
                    return new Container(
                      child: new GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(new MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  DetailHewan(list: list, index: i)));
                        },
                        child: Container(
                            margin: EdgeInsets.only(right:10),
                            width: 100,
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
                            child: Center(
                                child: Text(
                              list[i]['nama'],
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ))),
                      ),
                    );
                  }),
            ),
          ),
          
          Text(
            "List Data",
            style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: new ListView.builder(
                itemCount: list == null ? 0 : list.length,
                itemBuilder: (context, i) {
                  return new Container(
                    child: new GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(new MaterialPageRoute(
                            builder: (BuildContext context) =>
                                DetailHewan(list: list, index: i)));
                      },
                      child: new Card(
                        color: Colors.white,
                        child: new ListTile(
                          title: new Text(list[i]['nama']),
                          leading: new Icon(Icons.list),
                          subtitle: new Text("Jenis :${list[i]['jenis']}"),
                        ),
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}