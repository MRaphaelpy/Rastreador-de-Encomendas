import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

// ignore: camel_case_types
class Error_Page extends StatefulWidget {
  const Error_Page({ Key? key }) : super(key: key);

  @override
  _Error_PageState createState() => _Error_PageState();
}
// ignore: camel_case_types
class _Error_PageState extends State<Error_Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(children: [
           Text("Oops!!, Algo deu errado...",style: TextStyle(
                  fontSize: 35,
                  color: Colors.purple[800],
                  fontWeight: FontWeight.bold,
                ),
                ),
                Image.asset("images/errorRobot.png"),
                Text("Verifique o codigo de rastreio.",style: TextStyle(
                  fontSize: 20,
                  color: Colors.black87
                ),
                ),
                Text("Talvez sua Encomenda nao \n      tenha sido postada.",style: TextStyle(
                  fontSize: 22,
                  color: Colors.black87
                ),
                ),
            Align(
              heightFactor: 7,
              alignment: Alignment.bottomCenter,
              child:SizedBox(
            width: 400,
            height: 50,
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.purple[800]),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              ),
              onPressed: (){
                Navigator.pop(context);
              },
              child: const Text("Voltar",
              style: TextStyle(
                fontSize: 18,
              ),
              ),
            ),
          ),
            ),
         const   SizedBox(
              height: 10,
            ),
          ],),
          ),
      ),
    );
  }
}