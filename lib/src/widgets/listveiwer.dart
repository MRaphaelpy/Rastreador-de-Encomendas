import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ListViwerBuilder extends StatelessWidget {
  Map? encomendasTrack;

  ListViwerBuilder({this.encomendasTrack});

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount:
            // ignore: unnecessary_null_comparison
            encomendasTrack == null ? 0 : encomendasTrack!["quantidade"],
        itemBuilder: (BuildContext context, int index) {
          final String statusEncomenda =
              encomendasTrack!["eventos"][index]["status"];
          final String dataEncomenda =
              encomendasTrack!["eventos"][index]["data"];
          final String localEncomenda =
              encomendasTrack!["eventos"][index]["local"];

          return SingleChildScrollView(
            // ignore: sized_box_for_whitespace
            child: Container(
              width: 20.h,
              //   height: 10.w,
              child: Column(
                children: [
                  SizedBox(
                    height: 110,
                    child: Card(
                      shadowColor: Colors.purple,
                      elevation: 6,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        //  side: const BorderSide(color: Colors.grey, width: 0.3),
                      ),
                      // color: Colors.grey[100],
                      child: Row(
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
                                      Image.asset(
                                        "images/direita.gif",
                                        scale: 8,
                                      ),
                                      Text(
                                        ' ' + statusEncomenda,
                                        style: const TextStyle(
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  "No dia: " + dataEncomenda,
                                  style: const TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                                Text(
                                  'De: ' + localEncomenda,
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
            ),
          );
        },
      );
    });
  }
}
