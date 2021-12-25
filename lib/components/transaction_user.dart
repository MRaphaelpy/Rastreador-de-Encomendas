import 'package:flutter/material.dart';
import '../dialogalert.dart';
import 'transactions_list.dart';
import 'package:track/models.dart';

class TransactionUser extends StatefulWidget {
  const TransactionUser({ Key? key }) : super(key: key);
  

  @override
  _TransactionUserState createState() => _TransactionUserState();
}

class _TransactionUserState extends State<TransactionUser> {
  _addTransaction(String codname, String name){
  final newTransaction = Transaction(
    title: name,
    trackCode: codname,
  );
  setState(() {
    _transaction.add(newTransaction);
  });
}

   final List<Transaction> _transaction = [

];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
        children: [
         TransactionList(_transaction),
    
        ],
      ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          showDialog(context: context, builder: (context){
            return DialogBom_Alert(_addTransaction);
          });
          
        },
        backgroundColor: Colors.purple,
        shape: OutlineInputBorder(),
        child: Icon(Icons.add),
      ),
    );
  }
}