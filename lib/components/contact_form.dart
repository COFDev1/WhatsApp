import 'package:flutter/material.dart';
import 'package:whatsappcentral/models/contact.dart';

class ContactForm extends StatefulWidget {
  final void Function(String, String) onSubmit;
  final List<Contact>? listContact;

  const ContactForm({
    required this.onSubmit,
    this.listContact,
    super.key,
  });

  @override
  State<ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  String _valueDefault = "Tipo de Contato";
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _categoriaController = TextEditingController();
  final _nivelContato = TextEditingController();
  final _cidades = [
    "Tipo de Contato",
    "WhatsApp",
    "Celular",
    "Comercial",
    "Residencial",
  ];

  void _editContact() {
    _nameController.text = widget.listContact![0].name;
    _phoneController.text = widget.listContact![0].phone;
  }

  _submitForm() {
    final name = _nameController.text;
    final phone = _phoneController.text;

    widget.onSubmit(name, phone);
  }

  void _dropDownItemSelected(String? novoItem) {
    setState(
      () {
        _valueDefault = novoItem!;
      },
    );
    // onChanged: (String string) => setState(() => selectedItem = string),
  }

  @override
  Widget build(BuildContext context) {
    if (widget.listContact!.isNotEmpty) {
      _editContact();
    }
    // int index = widget.listContact!.indexWhere((item) => item["id"] == "11");

    // print( "Posição do registro ${index}");

    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Padding(
          padding: EdgeInsets.only(
            top: 10,
            right: 10,
            left: 10,
            bottom: 20 + MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            children: [
              TextField(
                controller: _nameController,
                onSubmitted: (_) => {},
                decoration: const InputDecoration(labelText: "Nome"),
              ),
              TextField(
                controller: _phoneController,
                onSubmitted: (_) => {},
                decoration: const InputDecoration(labelText: "Telefone"),
              ),

              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Column(
                    children: [
                      DropdownButton<String>(
                        items: _cidades.map((String dropDownStringItem) {
                          return DropdownMenuItem<String>(
                            value: dropDownStringItem,
                            child: Text(dropDownStringItem),
                          );
                        }).toList(),
                        onChanged: _dropDownItemSelected,
                        value: "Tipo de Contato",
                      ),
                    ],
                  ),
                ),
              ),
              TextField(
                controller: _nivelContato,
                onSubmitted: (_) => {},
                decoration:
                    const InputDecoration(labelText: "Nível do Contato"),
              ),
              // Text("Hint text", textAlign: TextAlign.end)
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  ElevatedButton(
                    child: Text(
                      "Gravar",
                      style: TextStyle(
                        color: Theme.of(context).textTheme.button?.color,
                      ),
                    ),
                    onPressed: _submitForm,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
