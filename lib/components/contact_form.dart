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
  bool _lEdit = true;
  String dropdownValue = list.first;
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _descriptionContact = TextEditingController();
  final email = TextEditingController();

  void _editContact() {
    _nameController.text = widget.listContact![0].name;
    _phoneController.text = widget.listContact![0].phone;
    _phoneController.text = widget.listContact![0].phone;
    _lEdit = false;
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
    if (_lEdit && widget.listContact!.isNotEmpty) {
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
                  // initialValue: "Pedrao",
                  decoration: const InputDecoration(labelText: 'Nome'),
                  // textInputAction: TextInputAction.next,
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
                  keyboardType: TextInputType.phone,
                  validator: (_phone) {
                    final phone = _phone ?? '';

                    if (phone.trim().isEmpty) {
                      return "Telefone é obrigatório.";
                    }

                    if (phone.trim().length < 11) {
                      return "Telefone deve ter 11 dígitos.";
                    }
                    return null;
                  },
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: DropdownButtonFormField<String>(
                      value: dropdownValue,
                      // hint: Text('Select an option'),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownValue = newValue!;
                        });
                      },
                      validator: (String? value) {
                        if (value == list.first) {
                          return "Opção inválida";
                        }
                        return null;
                      },
                      items: list.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: TextFormField(
                    controller: _descriptionContact,
                    decoration: const InputDecoration(
                        labelText: "Descrição do Contato"),
                    // textInputAction: TextInputAction.next,
                    maxLength: 30,
                    validator: (_description) {
                      final description = _description ?? '';

                      if (description.trim().isEmpty) {
                        return "O preenchimento do campo Descrição do Contato é obrigatório.";
                      }

                      if (description.trim().length < 3) {
                        return "Descrição do Contato precisa no mínimo de 10 letras.";
                      }

                      return null;
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    ElevatedButton(
                      child: Text("Gravar"),
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
