import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {

String? codigo;
String? title;

HomePage({this.codigo, this.title});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  Map encomendasTrack = {};

  Future _getData() async {
    var response = await http.get(Uri.parse(
        "toke=${widget.codigo}"));

      encomendasTrack = jsonDecode(response.body);
    return encomendasTrack;
  }
  /*@override
  void initState() {
    this._getData();
  }*/
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
       //   extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: Text(widget.title.toString()),
          backgroundColor: Colors.purple,
        ),
        body: FutureBuilder(
          future: _getData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                  Image.asset("images/background.jpg"),
                  Container(
                        decoration: BoxDecoration(
                          border:Border.all(color: Colors.black) ,
                          color: Colors.purple[200]
                        ),
                        child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.qr_code,size: 30,),
                          SelectableText(encomendasTrack["codigo"]),
                          SizedBox(width: 190,),
                          Icon(Icons.mail,size: 30,),
                          Text( encomendasTrack["servico"]),
                        ],
                      ),
                      ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                  itemCount:
                      encomendasTrack == null ? 0 : encomendasTrack["quantidade"],
                  itemBuilder: (BuildContext context, int index) {
                    return SingleChildScrollView(
                      child:Column(
                        children: [
                        Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(color: Colors.grey, width: 2),
                        ),
                        color: Colors.grey[100],
                        child: Container(
                          padding: EdgeInsets.all(20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Image.asset("images/direita.gif" ,scale: 05,),
                                        Text(' '+
                                      encomendasTrack["eventos"][index]["status"]
                                          .toString(),
                                      style: TextStyle(fontSize: 20),
                                    ),
                                      ],
                                    ),
                                    Text("No dia: "+
                                      encomendasTrack["eventos"][index]["data"]
                                          .toString(),
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    Text('De: '+
                                      encomendasTrack["eventos"][index]["local"]
                                          .toString(),
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      ],) ,
                    );
                  },
                ),
                ],),
              );
            }else {
              return Center(
                child: Platform.isAndroid ? CircularProgressIndicator() : CupertinoActivityIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
