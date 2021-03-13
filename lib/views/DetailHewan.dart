import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:task5/views/EditHewan.dart';
import 'package:task5/views/HalamanHewan.dart';

class DetailHewan extends StatefulWidget {
  List list;
  int index;
  DetailHewan({this.list, this.index});
  @override
  _DetailHewanState createState() => _DetailHewanState();
}

class _DetailHewanState extends State<DetailHewan> {
  void deletedata() {
    var url = "http://192.168.18.4/flutter-server/deleteHewan.php";
    http.post(url, body: {'id_hewan': widget.list[widget.index]['id_hewan']});
  }

  void confirm() {
    AlertDialog alertDialog = new AlertDialog(
      content: new Text(
          "Are You Sure Want to Delete'${widget.list[widget.index]['nama']}'"),
      actions: <Widget>[
        new RaisedButton(
            child: new Text(
              'OK DELETE!',
              style: TextStyle(color: Colors.black),
            ),
            color: Colors.red,
            onPressed: () {
              deletedata();
              Navigator.of(context).push(new MaterialPageRoute(
                  builder: (BuildContext context) => new HalamanHewan()));
            }),
        new RaisedButton(
          child: new Text(
            'CANCEL',
            style: TextStyle(color: Colors.black),
          ),
          color: Colors.green,
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
    showDialog(context: context, child: alertDialog);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("${widget.list[widget.index]['jenis']}"),
        backgroundColor: Colors.brown,
      ),
      body: new ListView(
        children: <Widget>[
          new Container(
            padding: const EdgeInsets.all(10.0),
            height: 500.0,
            child: Row(
              children: <Widget>[
                new Expanded(
                    child: Card(
                  child: new Column(
                    children: <Widget>[
                      new Padding(padding: const EdgeInsets.only(top: 30.0)),
                      new Text(
                        widget.list[widget.index]['nama'],
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      new Text(
                        widget.list[widget.index]['jenis'],
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      new Text(
                        widget.list[widget.index]['deskripsi'],
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      new Padding(padding: const EdgeInsets.only(top: 30.0)),
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          new RaisedButton(
                            child: new Text('Edit'),
                            color: Colors.yellow[500],
                            onPressed: () => Navigator.of(context)
                                .push(new MaterialPageRoute(
                              builder: (BuildContext context) => new EditHewan(
                                  list: widget.list, index: widget.index),
                            )),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                          ),
                          new RaisedButton(
                            child: new Text('Delete',style: TextStyle(color: Colors.white),),
                            color: Colors.red,
                            onPressed: () => confirm(),
                          ),
                        ],
                      )
                    ],
                  ),
                ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
