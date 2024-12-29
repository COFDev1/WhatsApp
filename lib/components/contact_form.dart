import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  final _formKey = GlobalKey<FormState>();
  String dropdownValue = list.first;
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _nivelContato = TextEditingController();
  final email = TextEditingController();

  void _editContact() {
    _nameController.text = widget.listContact![0].name;
    _phoneController.text = widget.listContact![0].phone;
  }

  _submitForm() {
    final name = _nameController.text;
    final phone = _phoneController.text;

    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) {
      return;
    }
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
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Nome'),
                  textInputAction: TextInputAction.next,
                  maxLength: 30,
                  validator: (_name) {
                    final name = _name ?? '';

                    if (name.trim().isEmpty) {
                      return "Nome é obrigatório.";
                    }

                    if (name.trim().length < 3) {
                      return "Nome precisa no mínimo de 3 letras.";
                    }

                    return null;
                  },
                ),

                TextFormField(
                  controller: _phoneController,
                  decoration: const InputDecoration(
                    labelText: "Telefone", /*icon: Icon(Icons.phone)*/
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                  ],
                  maxLength: 11,
                  keyboardType: const TextInputType.numberWithOptions(),
                  validator: (_phone) {
                    final phone = _phone ?? '';

                    if (phone.trim().isEmpty) {
                      return "Telefone é obrigatório.";
                    }

                    if (phone.trim().length < 11) {
                      return "Telefone precisa de 11 dígitos.";
                    }
                    return null;
                  },
                ),

                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Column(
                      children: [
                        // DropdownButton<String>(
                        //   value: dropdownValue,
                        //   elevation: 16,
                        //   onChanged: (String? value) {
                        //     // This is called when the user selects an item.
                        //     setState(
                        //       () {
                        //         dropdownValue = value!;
                        //       },
                        //     );
                        //   },
                        //   items: list
                        //       .map<DropdownMenuItem<String>>((String value) {
                        //     return DropdownMenuItem<String>(
                        //       value: value,
                        //       child: Text(value),
                        //     );
                        //   }).toList(),
                        // ),
                        DropdownButtonFormField<String>(
                          value: dropdownValue,
                          // hint: Text('Select an option'),
                          onChanged: (String? newValue) {
                            setState(() {
                              dropdownValue = newValue!;
                            });
                          },
                          validator: (String? value) {
                            // if (value == null) {
                            if (value == list.first) {
                              return "Selecione uma opção válida";
                            }
                            return null;
                          },
                          items: list
                              .map<DropdownMenuItem<String>>((String value) {
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
      ),
    );
  }
}
