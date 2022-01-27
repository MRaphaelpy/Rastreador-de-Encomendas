import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:track/src/models/models.dart';

import '../../dialogalert.dart';
import 'encomendaspage.dart';
import 'help_page.dart';

class InicialPage extends StatefulWidget {
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
    return Sizer(
      builder: (context, orientacion, devicetipe) {
        return Scaffold(
          // backgroundColor: Colors.grey[350],
          body: ListView.builder(
            itemCount: transaction.length,
            itemBuilder: (context, index) {
              return _encomendasCard(context, index);
            },
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              _showEncomendas();
            },
            child: const Icon(Icons.add),
            backgroundColor: Colors.purple,
            shape: const OutlineInputBorder(),
          ),
        );
      },
    );
  }

  Widget _encomendasCard(BuildContext context, int index) {
    return GestureDetector(
      child: Card(
        elevation: 12,
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
                                    style: TextStyle(
                                        color: Colors.purple, fontSize: 18),
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
          subtitle: Row(
            children: [
              Image.asset(
                "images/code.gif",
                scale: 13,
              ),
              Text(transaction[index].trackCode.toString().toUpperCase())
            ],
          ),
        ),
      ),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => EncomendasPage(
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
              child: DialogBom_Alert(
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
