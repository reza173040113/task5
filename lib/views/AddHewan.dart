import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:task5/views/HalamanHewan.dart';
import 'package:task5/views/HalamanHome.dart';

class AddHewan extends StatefulWidget {
  @override
  _AddHewanState createState() => _AddHewanState();
}

class _AddHewanState extends State<AddHewan> {
  TextEditingController namaController = new TextEditingController();
  TextEditingController jenisController = new TextEditingController();
  TextEditingController deskripsiController = new TextEditingController();
  TextEditingController kategoriController = new TextEditingController();

  void addData() {
    var url = "http://192.168.18.4/flutter-server/addHewan.php";
    http.post(url, body: {
      "nama": namaController.text,
      "jenis": jenisController.text,
      "deskripsi": deskripsiController.text,
      "id_kategori": kategoriController.text
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Text('Add Data Hewan'),
        backgroundColor: Colors.brown,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: <Widget>[
            new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Padding(padding: new EdgeInsets.only(top: 15.0)),
                new TextField(
                    controller: namaController,
                    decoration: new InputDecoration(
                        hintText: "Input Nama Hewan",
                        labelText: "Nama Hewan",
                        border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(20.0)))),
                new Padding(padding: new EdgeInsets.all(5.0)),
                new TextField(
                    controller: jenisController,
                    decoration: new InputDecoration(
                        hintText: "Input Jenis Hewan",
                        labelText: "Jenis Hewan",
                        border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(20.0)))),
                new Padding(padding: new EdgeInsets.all(5.0)),
                new TextField(
                    controller: deskripsiController,
                    decoration: new InputDecoration(
                        hintText: "Input Deskripsi",
                        labelText: "Deskripsi",
                        border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(20.0)))),
                new Padding(padding: new EdgeInsets.all(5.0)),
                new TextField(
                    controller: kategoriController,
                    decoration: new InputDecoration(
                        hintText: "Input Kategori",
                        labelText: "Kategori",
                        border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(20.0)))),
                new Padding(padding: const EdgeInsets.all(5.0)),
                Center(
                  child: Container(
                    width: 300,
                    child: new RaisedButton(
                      child: new Text("Add Data",style: TextStyle(color: Colors.white),),
                      color: Colors.brown,
                      onPressed: () {
                        addData();
                        Navigator.of(context).push(new MaterialPageRoute(
                            builder: (BuildContext context) =>
                                new HalamanHome()));
                      },
                    ),
                  ),
                ),
                Text("Kategori : "),
                Text("1 = Karnivora"),
                Text("2 = Herbivora"),
                Text("3 = Omnivora"),
              ],
            )
          ],
        ),
      ),
    );
  }
}
