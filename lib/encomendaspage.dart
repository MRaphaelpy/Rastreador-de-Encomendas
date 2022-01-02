import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:track/error_page.dart';
import 'package:sizer/sizer.dart';

// ignore: must_be_immutable
class EncomendasPage extends StatefulWidget {

String? codigo;
String? title;

EncomendasPage({Key? key, this.codigo, this.title}) : super(key: key);

  @override
  _EncomendasPageState createState() => _EncomendasPageState();
}

class _EncomendasPageState extends State<EncomendasPage> {
  
  Map encomendasTrack = {};

  Future _getData() async {
    var response = await http.get(Uri.parse(
        "YOUR TOKEN HERE${widget.codigo}"));

      encomendasTrack = jsonDecode(response.body);
    return encomendasTrack;
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType){
      return Scaffold(
        backgroundColor: Colors.grey[350],
     //   extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(widget.title.toString()),
        centerTitle: true,
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
                        const SizedBox(width: 90,),
                        const Icon(Icons.mail,size: 30,),
                        Text(encomendasTrack['servico'].toString()),
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
                  final String statusEncomenda = encomendasTrack["eventos"][index]["status"];
                  final String dataEncomenda = encomendasTrack["eventos"][index]["data"];
                  final String localEncomenda = encomendasTrack["eventos"][index]["local"];

                  return SingleChildScrollView(
                    // ignore: sized_box_for_whitespace
                    child:Container(
                      width: 20.w,
                      height: 13.5.h,
                      child: Column(
                        children: [
                        SizedBox(
                          height: 110,
                          child: Card(
                            shadowColor: Colors.purple,
                            elevation: 6,
                            shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: const BorderSide(color: Colors.grey, width: 0.3),
                          ),
                          color: Colors.grey[100],
                          child:Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Column(
                                    children: [
                                      Center(
                                        heightFactor: 2,
                                        child: Wrap(
                                          children: [
                                            Image.asset("images/direita.gif" ,scale: 8,),
                                            Text(' '+statusEncomenda,
                                                    style: const TextStyle(
                                                    fontSize: 15,
                                                    ),
                                              ),
                                          ],
                                        ),
                                      ),
                                      Text("No dia: "+dataEncomenda,
                                          style: const TextStyle(
                                          fontSize: 15,
                                          ),
                                      ),
                                      Text('De: '+localEncomenda,
                                        style: const TextStyle(
                                        fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                      ),
                    ) ,
                  );
                },
              ),
              ],
              ),
            );
          }
          if(snapshot.hasError){
            return const Error_Page();
          }else {
            return Center(
              child: Platform.isAndroid ? const CircularProgressIndicator(
                color: Colors.purple,
              ) : const CupertinoActivityIndicator(),
            );
          }
        },
      ),
    );
    },
    );
  }
}
