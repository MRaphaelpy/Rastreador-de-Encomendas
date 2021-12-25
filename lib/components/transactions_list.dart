import 'package:flutter/material.dart';
import 'package:track/models.dart';

import '../homepage.dart';

class TransactionList extends StatelessWidget {
 final List<Transaction> transactions;

 TransactionList(this.transactions);
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(8),
        child: Column(children: transactions.map((tr){
        return ListView(
          shrinkWrap: true,
          children: [
            ListTile(
              onTap: (){
                 Navigator.push(context, MaterialPageRoute(builder: (context)=> HomePage(codigo: tr.trackCode, title: tr.title,)));
              },
              leading: Image.asset("images/truck.png"),
              title: Text(tr.title!),
              subtitle: Text(tr.trackCode!),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(onPressed: null,
                   icon:Icon(Icons.delete_outline, size: 30,) ,
                   ),
                ],
              ),
            ),
          ],
        );
      }).toList(),
      ),
      ),
    ) ;
  }
}


/*Card(
          child: Text(tr.title!, style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          ),
        )*/

/*ListView(
          children: [
            ListTile(
              title: Text("d"),
            )
          ],
          shrinkWrap: true,
        )*/