import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:track/src/widgets/listveiwer.dart';
import '../pages/error_page.dart';
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
    var response = await http.get(
      Uri.parse(
          "https://api.linketrack.com/track/json?user=nitrocraftgamer@gmail.com&token=5e5c4c86c8300b934b1c9b372555c97ff629dc39bd9fb6ff6703c65b6003c468&codigo=${widget.codigo}"),
    );

    encomendasTrack = jsonDecode(response.body);
    return encomendasTrack;
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return Scaffold(
          // backgroundColor: Colors.grey[350],
          //   extendBodyBehindAppBar: true,
          appBar: AppBar(
            title: Text(
              widget.title.toString(),
            ),
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
                          border: Border.all(color: Colors.black),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.qr_code,
                              size: 30,
                            ),
                            SelectableText(encomendasTrack["codigo"]),
                            const SizedBox(
                              width: 90,
                            ),
                            const Icon(
                              Icons.mail,
                              size: 30,
                            ),
                            Text(encomendasTrack['servico'].toString()),
                          ],
                        ),
                      ),
                      ListViwerBuilder(
                        encomendasTrack: encomendasTrack,
                      ),
                    ],
                  ),
                );
              }
              if (snapshot.hasError) {
                return const Error_Page();
              } else {
                return Center(
                  child: Platform.isAndroid
                      ? const CircularProgressIndicator(
                          color: Colors.purple,
                        )
                      : const CupertinoActivityIndicator(),
                );
              }
            },
          ),
        );
      },
    );
  }
}
