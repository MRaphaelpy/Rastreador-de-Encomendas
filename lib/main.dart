import 'package:flutter/material.dart';
import 'package:track/components/transaction_user.dart';
import 'package:track/help_page.dart';
import 'package:track/homepage.dart';

void main() {
  runApp(MaterialApp(
    home: InicialPage(),
  ));
}

class InicialPage extends StatefulWidget {
  const InicialPage({Key? key}) : super(key: key);

  @override
  _InicialPageState createState() => _InicialPageState();
}

class _InicialPageState extends State<InicialPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: Image.asset("images/pinguin.jpg")),
              decoration: BoxDecoration(color: Colors.purple),
              accountName: null,
              accountEmail: null,
            ),
            ListTile(
              leading: Icon(Icons.help),
              title: Text("Agradecimentos e Ajuda"),
              subtitle: Text("Pessoas que ajudaram, Links uteis e Ajuda"),
              onTap:(){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> Help_Page()));
              } ,
            ),
          ],
        ),
      ),
      backgroundColor: Colors.grey[350],
      appBar: AppBar(
        title: Text("Rastreamento"),
        centerTitle: true,
        backgroundColor: Colors.purple,
      ),
      body:TransactionUser() ,
    );
  }
}
