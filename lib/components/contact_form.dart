import 'package:flutter/material.dart';
import 'package:whatsappcentral/models/contact.dart';

const List<String> list = <String>[
  "Tipo de Contato",
  "WhatsApp",
  "Celular",
  "Comercial",
  "Residencial"
];

class ContactForm extends StatefulWidget {
  // final void Function(String, String) onSubmit;
  final void Function(String, String, int) onSubmit;
  final List<Contact>? listContact;
  final int? index;

  const ContactForm({
    required this.onSubmit,
    this.listContact,
    this.index,
    super.key,
  });

  @override
  State<ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  String dropdownValue = list.first;
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _nivelContato = TextEditingController();

  void _editContact() {
    _nameController.text = widget.listContact![0].name;
    _phoneController.text = widget.listContact![0].phone;
  }

  _submitForm() {
    final name = _nameController.text;
    final phone = _phoneController.text;

    widget.onSubmit(
      name,
      phone,
      widget.index!,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.listContact!.isNotEmpty) {
      _editContact();
    }

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
                keyboardType: TextInputType.number,
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
                        value: dropdownValue,
                        elevation: 16,
                        onChanged: (String? value) {
                          // This is called when the user selects an item.
                          setState(() {
                            dropdownValue = value!;
                          });
                        },
                        items:
                            list.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      )
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
