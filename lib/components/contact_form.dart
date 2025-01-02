import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:whatsappcentral/models/contact.dart';

class ContactForm extends StatefulWidget {
  final void Function(String, String, int, String, String) onSubmit;
  final List<Contact>? listContact;
  final int? index;
  final bool edition;

  const ContactForm({
    required this.onSubmit,
    required this.edition,
    this.listContact,
    this.index,
    super.key,
  });

  @override
  State<ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  bool _lEdit = true;
  String dropdownValue = "";
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _typeContactController = TextEditingController();
  final _descriptionContactController = TextEditingController();
  final email = TextEditingController();
  List<String> options = [];

  @override
  void initState() {
    super.initState();

    options = loadOptionions();
  }

  void _editContact() {
    // options = loadOptionions();

    dropdownValue = options.first;

    _lEdit = widget.edition;
    _nameController.text = widget.listContact![0].name;
    _phoneController.text = widget.listContact![0].phone;
    _typeContactController.text = widget.listContact![0].type;
    _descriptionContactController.text = widget.listContact![0].description;

    int position = options.indexWhere(
        (element) => element.startsWith(_typeContactController.text));

    if (position >= 0) {
      options = _lEdit ? options : [options[position]];

      dropdownValue = _lEdit ? options[position] : options[0];
    }
    _lEdit = false;
  }

  List<String> loadOptionions() {
    List<String> options = <String>[
      "Tipo de Contato",
      "WhatsApp",
      "Celular",
      "Comercial",
      "Residencial"
    ];
    return options;
  }

  _submitForm() {
    final String name = _nameController.text;
    final String phone = _phoneController.text;
    final String type = _typeContactController.text;
    final String description = _descriptionContactController.text;

    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) {
      return;
    }

    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(
          widget.edition ? "Gravação" : "Exclusão",
          style: TextStyle(color: widget.edition ? Colors.black : Colors.red),
        ),
        content: const Text("Deseja confirmar a operação ?"),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context, 'OK');
              widget.onSubmit(name, phone, widget.index!, type, description);
            },
            child: const Text("OK"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context, "Cancel");
            },
            child: const Text("Cancel"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // options = loadOptionions();

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
                  readOnly: !widget.edition,
                  decoration: const InputDecoration(labelText: "Nome"),
                  // textInputAction: TextInputAction.next,
                  maxLength: 30,
                  validator: (value) {
                    final name = value ?? '';

                    if ((name.trim().isEmpty) && (widget.edition)) {
                      return "Nome é obrigatório.";
                    }

                    if ((name.trim().length < 3) && (widget.edition)) {
                      return "Nome precisa no mínimo de 3 letras.";
                    }

                    return null;
                  },
                ),
                TextFormField(
                  controller: _phoneController,
                  readOnly: !widget.edition,
                  decoration: const InputDecoration(
                    labelText: "Telefone", /*icon: Icon(Icons.phone)*/
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                  ],
                  maxLength: 11,
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    final phone = value ?? '';

                    if ((phone.trim().isEmpty) && (widget.edition)) {
                      return "Telefone é obrigatório.";
                    }

                    if ((phone.trim().length < 11) && (widget.edition)) {
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
                      onChanged: !widget.edition
                          ? null
                          : (String? newValue) {
                              setState(() {
                                dropdownValue = newValue!;
                              });
                            },
                      validator: (String? value) {
                        if ((value == options.first) && (widget.edition)) {
                          return "Opção inválida";
                        }
                        return null;
                      },
                      items:
                          options.map<DropdownMenuItem<String>>((String value) {
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
                    controller: _descriptionContactController,
                    readOnly: !widget.edition,
                    decoration: const InputDecoration(
                        labelText: "Descrição do Contato"),
                    maxLength: 30,
                    validator: (value) {
                      final description = value ?? '';

                      if ((description.trim().isEmpty) && (widget.edition)) {
                        return "O preenchimento do campo Descrição do Contato é obrigatório.";
                      }

                      if ((description.trim().length < 6) && (widget.edition)) {
                        return "Descrição do Contato precisa ter,no mínimo, de 6 letras.";
                      }

                      return null;
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: _submitForm,
                      child: const Text("Gravar"),
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
