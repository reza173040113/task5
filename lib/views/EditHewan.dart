import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:task5/views/HalamanHewan.dart';
import 'package:task5/views/HalamanHome.dart';

class EditHewan extends StatefulWidget {
  final List list;
  final int index;
  EditHewan({this.list, this.index});
  @override
  _EditHewanState createState() => _EditHewanState();
}

class _EditHewanState extends State<EditHewan> {
  TextEditingController namaController;
  TextEditingController jenisController;
  TextEditingController deskripsiController;
  TextEditingController kategoriController;

  void editData() {
    var url = "http://inisialer.000webhostapp.com/editHewan.php";
    http.post(url, body: {
      "id_hewan": widget.list[widget.index]['id_hewan'],
      "nama": namaController.text,
      "jenis": jenisController.text,
      "deskripsi": deskripsiController.text,
      "id_kategori": kategoriController.text
    });
  }

  @override
  void initState() {
    namaController =
        new TextEditingController(text: widget.list[widget.index]['nama']);
    jenisController =
        new TextEditingController(text: widget.list[widget.index]['jenis']);
    deskripsiController =
        new TextEditingController(text: widget.list[widget.index]['deskripsi']);
    kategoriController =
        new TextEditingController(text: widget.list[widget.index]['id_kategori']);
    super.initState();
  }

  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Text('Edit Data Hewan'),
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
                          borderRadius: new BorderRadius.circular(20.0))),
                ),
                new Padding(padding: new EdgeInsets.only(top: 15.0)),
                new TextField(
                  controller: jenisController,
                  decoration: new InputDecoration(
                      hintText: "Input Jenis Hewan",
                      labelText: "Jenis Hewan",
                      border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(20.0))),
                ),
                new Padding(padding: new EdgeInsets.only(top: 15.0)),
                new TextField(
                  controller: deskripsiController,
                  decoration: new InputDecoration(
                      hintText: "Input Deskripsi",
                      labelText: "Deskripsi",
                      border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(20.0))),
                ),
                new Padding(padding: new EdgeInsets.only(top: 15.0)),
                new TextField(
                  controller: kategoriController,
                  decoration: new InputDecoration(
                      hintText: "Input Kategori",
                      labelText: "Kategori",
                      border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(20.0))),
                ),
                new Padding(padding: new EdgeInsets.only(top: 15.0)),
                Container(
                  child: Center(
                    child: new RaisedButton(
                      child: new Text(' Edit Data',style: TextStyle(color: Colors.white),),
                      color: Colors.brown,
                      onPressed: () {
                        editData();
                        Navigator.of(context).pushReplacement(new MaterialPageRoute(
                            builder: (BuildContext context) => new HalamanHewan()));
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
