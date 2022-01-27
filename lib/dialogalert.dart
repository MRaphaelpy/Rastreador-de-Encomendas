// ignore_for_file: deprecated_member_use
import './src/models/models.dart';
import 'package:validatorless/validatorless.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class DialogBom_Alert extends StatefulWidget {
  final TransactionsM? encomenda;
  final void Function(String, String)? onSubmit;

  // ignore: use_key_in_widget_constructors
  const DialogBom_Alert({this.encomenda, this.onSubmit});

  @override
  State<DialogBom_Alert> createState() => _DialogBom_AlertState();
}

// ignore: camel_case_types
class _DialogBom_AlertState extends State<DialogBom_Alert> {
  TextEditingController encomendaController = TextEditingController();
  TextEditingController nomeController = TextEditingController();

  String? codigo;
  String? nomeEncomenda;

// ignore: non_constant_identifier_names
  void SaveTrackCode() {
    codigo = encomendaController.text;
    nomeEncomenda = nomeController.text;
  }

  final _formKey = GlobalKey<FormState>();

  // ignore: unused_field
  bool _updEncomenda = false;
  late TransactionsM _editedEncomenda;

  @override
  void initState() {
    super.initState();
    if (widget.encomenda == null) {
      _editedEncomenda = TransactionsM();
    } else {
      _editedEncomenda = TransactionsM.fromMap(widget.encomenda!.toMap());
      nomeController.text = _editedEncomenda.title;
      encomendaController.text = _editedEncomenda.trackCode;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
          // ignore: unnecessary_const
          borderRadius: const BorderRadius.all(Radius.circular(30))),
      title: const Text(
        "Adicionar Codigo",
        style: TextStyle(color: Colors.purple),
      ),
      content: Wrap(
        children: [
          Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  onChanged: (text) {
                    _updEncomenda = true;
                    setState(() {
                      _editedEncomenda.title = text;
                    });
                  },
                  validator: Validatorless.required("Preciso de Um Nome :)"),
                  controller: nomeController,
                  decoration: const InputDecoration(
                    label: Text("Nome da Encomenda"),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                TextFormField(
                  onChanged: (text) {
                    _updEncomenda = true;
                    _editedEncomenda.trackCode = text;
                  },
                  validator: Validatorless.multiple([
                    Validatorless.required("Digite um codigo de Rastreio"),
                    Validatorless.min(13, "Codigo de Rastreio Invalido")
                  ]),
                  controller: encomendaController,
                  maxLength: 13,
                  decoration: const InputDecoration(
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
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  "Cancelar",
                  style: TextStyle(color: Colors.black),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                )),
            const SizedBox(
              width: 40,
            ),
            ElevatedButton(
                onPressed: () {
                  var formValid = _formKey.currentState?.validate() ?? false;
                  if (formValid) {
                    SaveTrackCode();
                    //  onSubmit(title, codigo);
                    Navigator.pop(context, _editedEncomenda);
                  }
                },
                child: const Text("Confirmar"),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.purple),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                )),
          ],
        ),
      ],
    );
  }
}
