import 'package:flutter/material.dart';
import 'package:track/help_page.dart';
import 'package:track/homepage.dart';
import 'package:track/models.dart';
import 'dialogalert.dart';
void main(){
  runApp(
   MaterialApp(
     home: InicialPage(),
   )
  );
}
class InicialPage extends StatefulWidget {
  const InicialPage({Key? key}) : super(key: key);
  @override
  _InicialPageState createState() => _InicialPageState();
}

class _InicialPageState extends State<InicialPage> {
EncomendaHelper helper = EncomendaHelper();

List transaction = [];

@override
void initState(){
  super.initState();
  _getAllEncomendas();
}
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
      body:ListView.builder(
        itemCount: transaction.length,
        itemBuilder:(context, index){
          return _encomendasCard(context, index);
        }),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            _showEncomendas();
          },
          child: Icon(Icons.add),
          backgroundColor: Colors.purple,
          shape: OutlineInputBorder(),
        ),
    );
  }
Widget _encomendasCard(BuildContext context, int index){
  return GestureDetector(
    child: Card(
      child: ListTile(
        trailing: Wrap(children: [
          IconButton(
        onPressed: (){
            showDialog(context: context, builder: (context){
              return AlertDialog(
                title: Text("Deseja Excluir esta Encomenda?"),
                actions: [
                  FlatButton(onPressed: (){
                     Navigator.pop(context);
                  },
                  child: Text("Nao"),
                  ),
                  FlatButton(onPressed: (){
                      setState(() {
                       helper.deleteEncomenda(transaction[index].id);
                         transaction.removeAt(index);
                     });
                     Navigator.pop(context);
                  },
                  child: Text("Sim"),
                  ),
                ],
              );
            });
        },
        icon: Icon(Icons.delete),
      ),
      IconButton(
        onPressed: (){
          _showEncomendas(encomenda: transaction[index]);
        },
        icon: Icon(Icons.edit),
      )
        ],),
      leading: Image.asset("images/truckan.gif"),
      title: Text(transaction[index].title ?? ""),
      subtitle: Text(transaction[index].trackCode),
    ),
    ),
    onTap: (){
    Navigator.push(context, MaterialPageRoute(builder: (context)=> HomePage(title: transaction[index].title, codigo: transaction[index].trackCode,)));
   },
  );
}

void _showEncomendas({TransactionsM? encomenda}) async{
 final recEncomenda = await showDialog(context: context, builder: (context){
    return DialogBom_Alert(encomenda: encomenda,);
});
if(recEncomenda != null){
  if(encomenda != null){
    await helper.updateEncomenda(recEncomenda);
       _getAllEncomendas();
  }else{
    await helper.saveEncomenda(recEncomenda);
  }
  _getAllEncomendas();
}
}
void _getAllEncomendas(){
  helper.getAllEncomendas().then((list){
   setState(() {
      transaction = list;
   });
  });
}
}

