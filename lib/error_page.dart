import 'package:flutter/material.dart';

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
      backgroundColor: Colors.grey[200],
      body: Column(
        children: [
          Align(
            heightFactor: 4,
            child: Text("Oops!!, Algo deu errado...",style: TextStyle(
              fontSize: 35,
              color: Colors.purple[800],
              fontWeight: FontWeight.bold,
            ),),
          ),
          Image.asset("images/errorRobot.png"),
        const  Align(
            heightFactor: 4,
            child: Text("Verifique o codigo de rastreio.",style: TextStyle(
              fontSize: 20,
              color: Colors.black87
            ),
            ),
          ),
      const Align(
            child: Text("Talvez sua Encomenda nao tenha sido postada.",style: TextStyle(
              fontSize: 20,
              color: Colors.black87
            ),
            ),
          ),
        ],
      ),
      floatingActionButton: Center(
        heightFactor: 4,
        child: SizedBox(
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
    );
  }
}