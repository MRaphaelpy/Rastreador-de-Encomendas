// ignore_for_file: deprecated_member_use
import 'dart:math';
import 'package:track/models.dart';
import 'package:validatorless/validatorless.dart';
import 'package:flutter/material.dart';

class DialogBom_Alert extends StatefulWidget {
 final TransactionsM? encomenda;
 final void Function(String, String)? onSubmit;
 
 DialogBom_Alert({this.encomenda, this.onSubmit});

  @override
  State<DialogBom_Alert> createState() => _DialogBom_AlertState();
}
class _DialogBom_AlertState extends State<DialogBom_Alert> {
TextEditingController encomendaController = TextEditingController();
TextEditingController nomeController = TextEditingController();

  String? codigo;
  String? nomeEncomenda;

void SaveTrackCode(){
    codigo = encomendaController.text;
    nomeEncomenda = nomeController.text;
}

final _formKey = GlobalKey<FormState>();

 bool _updEncomenda = false;
 late TransactionsM _editedEncomenda;

void initState(){
super.initState();
if(widget.encomenda == null){
_editedEncomenda = TransactionsM();
}else{
  _editedEncomenda = TransactionsM.fromMap(widget.encomenda!.toMap());
  nomeController.text = _editedEncomenda.title;
  encomendaController.text = _editedEncomenda.trackCode;
}
}

  @override
  Widget build(BuildContext context) {
    
    return AlertDialog(
      title: Text("Adicionar Codigo"),
      content:Wrap(children: [
        Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                onChanged: (text){
                  _updEncomenda = true;
                  setState(() {
                    _editedEncomenda.title = text;
                  });
                },
              validator: Validatorless.required("Preciso de Um Nome :)"),
            controller: nomeController,
            
            decoration: InputDecoration(
              label: Text("Nome da Encomenda"),
              border: OutlineInputBorder(),
            ),
                ),
                SizedBox(height: 25,
             ),
             TextFormField(
               onChanged: (text){
                 _updEncomenda = true;
                 _editedEncomenda.trackCode = text;
               },
               validator: Validatorless.multiple([
                 Validatorless.required("Digite um codigo de Rastreio"),
                 Validatorless.min(13, "Codigo de Rastreio Invalido")
               ]),
          controller: encomendaController,
          maxLength: 13,
          decoration: InputDecoration(
            label: Text("Codigo de Rastreio"),
            border: OutlineInputBorder(),
          ),
        ),
            ],
          ),
        ),
      ],
      ),
      actions: [
        FlatButton(onPressed: (){
          Navigator.pop(context);
        }, 
        child: Text("Cancelar"),
        ),
        FlatButton(
          onPressed: (){
            var formValid = _formKey.currentState?.validate() ?? false;
            if(formValid){
          SaveTrackCode();
          

          final title = encomendaController.text;
          final codigo = nomeController.text;
          final id = Random().nextDouble().toString();
          
       //  onSubmit(title, codigo);
         Navigator.pop(context, _editedEncomenda);
          }
          },
          child: Text("Confirmar"),
        ),
      ],
    );
  }
}
