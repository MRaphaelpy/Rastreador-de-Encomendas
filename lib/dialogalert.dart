import 'package:flutter/material.dart';
import 'package:track/homepage.dart';
import 'package:track/models.dart';

class DialogBom_Alert extends StatelessWidget {
  

final void Function(String, String) onSubmit;

DialogBom_Alert(this.onSubmit);

 List<Widget> teste =[];


TextEditingController encomendaController = TextEditingController();
TextEditingController nomeController = TextEditingController();

  String? codigo;
  String? nomeEncomenda;

void SaveTrackCode(){
    codigo = encomendaController.text;
    nomeEncomenda = nomeController.text;
}

  @override
  Widget build(BuildContext context) {
    
    return AlertDialog(
      title: Text("Adicionar Codigo"),
      content:Wrap(children: [
        TextField(
        controller: nomeController,
        decoration: InputDecoration(
          label: Text("Nome da Encomenda"),
          border: OutlineInputBorder(),
        ),
      ),
      SizedBox(height: 75,
      ),
      TextField(
        controller: encomendaController,
        maxLength: 13,
        decoration: InputDecoration(
          label: Text("Codigo de Rastreio"),
          border: OutlineInputBorder(),
        ),
      ),
      ],
      ),
      actions: [
        FlatButton(onPressed: (){
          Navigator.pop(context);
        }, 
        child: Text("Cancelar")),
        FlatButton(
          onPressed: (){
        
          SaveTrackCode();
          final title = encomendaController.text;
          final codigo = nomeController.text;
          onSubmit(title, codigo);
          Navigator.pop(context);

          },
          child: Text("Confirmar"),
        ),
      ],
    );
  }
}

