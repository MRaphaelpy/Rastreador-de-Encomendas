// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:track/help_page.dart';
import 'package:track/homepage.dart';
import 'package:track/models.dart';
import 'dialogalert.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
        primaryColor: Colors.purple,
     //   hintColor: Colors.purple,
        accentColor: Colors.purple,
        visualDensity: VisualDensity.adaptivePlatformDensity),
    home: const InicialPage(),
  ));
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
  void initState() {
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
              decoration: const BoxDecoration(color: Colors.purple),
              accountName: null,
              accountEmail: null,
            ),
            ListTile(
              leading: const Icon(Icons.help),
              title: const Text("Agradecimentos e Ajuda"),
              subtitle: const Text("Pessoas que ajudaram, Links uteis e Ajuda"),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Help_Page()));
              },
            ),
          ],
        ),
      ),
      backgroundColor: Colors.grey[350],
      appBar: AppBar(
        title: const Text("Rastreamento"),
        centerTitle: true,
        backgroundColor: Colors.purple,
      ),
      body: ListView.builder(
          itemCount: transaction.length,
          itemBuilder: (context, index) {
            return _encomendasCard(context, index);
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showEncomendas();
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.purple,
        shape: const OutlineInputBorder(),
      ),
    );
  }

  Widget _encomendasCard(BuildContext context, int index) {
    return GestureDetector(
      child: Card(
        shape: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        child: ListTile(
          trailing: Wrap(
            children: [
              IconButton(
                onPressed: () {
                  showGeneralDialog(
                      barrierColor: Colors.black.withOpacity(0.5),
                      transitionBuilder: (context, a1, a2, widget) {
                        return Transform.scale(
                          scale: a1.value,
                          child: Opacity(
                            opacity: a1.value,
                            child: AlertDialog(
                              contentPadding: const EdgeInsets.only(top: 10),
                              shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                              ),
                              backgroundColor: Colors.grey[200],
                              title: Column(
                                children: [
                                  Align(
                                    alignment: Alignment.topCenter,
                                    child: Image.asset(
                                      'images/lixeira2.gif',
                                      scale: 3,
                                    ),
                                  ),
                                  const Text(
                                    "Deseja excluir está encomenda?",
                                    style: TextStyle(color: Colors.purple),
                                  ),
                                ],
                              ),
                              actions: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: 100,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Colors.purple),
                                          shape: MaterialStateProperty.all(
                                            RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                            ),
                                          ),
                                        ),
                                        child: const Text("Não"),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 50,
                                    ),
                                    SizedBox(
                                      width: 100,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          setState(() {
                                            helper.deleteEncomenda(
                                                transaction[index].id);
                                            transaction.removeAt(index);
                                          });
                                          Navigator.pop(context);
                                        },
                                        child: const Text(
                                          "Sim",
                                          style:
                                              TextStyle(color: Colors.black87),
                                        ),
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Colors.white),
                                          shape: MaterialStateProperty.all(
                                            RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      },
                      transitionDuration: const Duration(milliseconds: 200),
                      barrierDismissible: true,
                      barrierLabel: '',
                      context: context,
                      pageBuilder: (context, animation1, animation2) {
                        return widget;
                      });
                },
                icon: const Icon(Icons.delete),
              ),
              IconButton(
                onPressed: () {
                  _showEncomendas(encomenda: transaction[index]);
                },
                icon: const Icon(Icons.edit),
              )
            ],
          ),
          leading: Image.asset("images/truckan.gif"),
          title: Text(transaction[index].title ?? ""),
          subtitle: Text(transaction[index].trackCode),
        ),
      ),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => HomePage(
                      title: transaction[index].title,
                      codigo: transaction[index].trackCode,
                    )));
      },
    );
  }

  void _showEncomendas({TransactionsM? encomenda}) async {
    final recEncomenda = await showGeneralDialog(
    barrierColor: Colors.black.withOpacity(0.5),
    transitionBuilder: (context, a1, a2, widget) {
      return Transform.scale(
        scale: a1.value,
        child: Opacity(
          opacity: a1.value,
          child:DialogBom_Alert(
            encomenda: encomenda,
          ),
        ),
      );
    },
    transitionDuration: const Duration(milliseconds: 200),
    barrierDismissible: true,
    barrierLabel: '',
    context: context,
    pageBuilder: (context, animation1, animation2) {
      return widget;
    });
    if (recEncomenda != null) {
      if (encomenda != null) {
        await helper.updateEncomenda(recEncomenda);
        _getAllEncomendas();
      } else {
        await helper.saveEncomenda(recEncomenda);
      }
      _getAllEncomendas();
    }
  }

  void _getAllEncomendas() {
    helper.getAllEncomendas().then((list) {
      setState(() {
        transaction = list;
      });
    });
  }
}


