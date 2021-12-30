import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:track/error_page.dart';

// ignore: must_be_immutable
class HomePage extends StatefulWidget {

String? codigo;
String? title;

HomePage({Key? key, this.codigo, this.title}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  Map encomendasTrack = {};

  Future _getData() async {
    var response = await http.get(Uri.parse(
        "https://api.linketrack.com/track/json?user=nitrocraftgamer@gmail.com&token=5e5c4c86c8300b934b1c9b372555c97ff629dc39bd9fb6ff6703c65b6003c468&codigo=${widget.codigo}"));

      encomendasTrack = jsonDecode(response.body);
    return encomendasTrack;
  }

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
                          const Icon(Icons.qr_code,size: 30,),
                          SelectableText(encomendasTrack["codigo"]),
                          const SizedBox(width: 190,),
                          const Icon(Icons.mail,size: 30,),
                          Text( encomendasTrack["servico"]),
                        ],
                      ),
                      ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                  itemCount:
                      // ignore: unnecessary_null_comparison
                      encomendasTrack == null ? 0 : encomendasTrack["quantidade"],
                  itemBuilder: (BuildContext context, int index) {
                    return SingleChildScrollView(
                      child:Column(
                        children: [
                        Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: const BorderSide(color: Colors.grey, width: 2),
                        ),
                        color: Colors.grey[100],
                        child: Container(
                          padding: const EdgeInsets.all(20),
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
                                      style: const TextStyle(fontSize: 20),
                                    ),
                                      ],
                                    ),
                                    Text("No dia: "+
                                      encomendasTrack["eventos"][index]["data"]
                                          .toString(),
                                      style: const TextStyle(fontSize: 20),
                                    ),
                                    Text('De: '+
                                      encomendasTrack["eventos"][index]["local"]
                                          .toString(),
                                      style: const TextStyle(fontSize: 20),
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
            }
            if(snapshot.hasError){
              return const Error_Page();
            }else {
              return Center(
                child: Platform.isAndroid ? const CircularProgressIndicator(
                  color: Colors.purple,
                ) : const CupertinoActivityIndicator(
                  
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
