import 'package:flutter/material.dart';
import 'package:whatsappcentral/components/contact_form.dart';
import 'package:whatsappcentral/components/contact_item.dart';
import 'package:whatsappcentral/models/contact.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'dart:math';

class ListContacts extends StatefulWidget {
  List<Contact> lista = [];

  ListContacts({required this.lista, super.key});

  @override
  State<ListContacts> createState() => _ListContactsState();
}

class _ListContactsState extends State<ListContacts> {
  @override
  void initState() {
    super.initState();

    loadContact();
  }

  void loadContact() async {
    Map<String, String> request = {
      'Content-Type': 'application/json',
    };
    var url = "http://192.168.10.101:3001/contatos";

    final response = await http.get(Uri.parse(url));

    print("Lendo os dados retornados: ${response.body} ");

    if (response.body == 'null') return;
    var data = jsonDecode(response.body);
    final List<Contact> teste = [];

    data.forEach((element) {
      teste.add(Contact(
        id: element["id"],
        name: element["name"],
        phone: element["phone"],
      ));
    });
    setState(() {
      widget.lista = teste;
    });
    print("Valor retornado: ${widget.lista}");
  }

  void _updateContact(String name, String phone, int index) {
    final newContact = Contact(
      id: Random().nextDouble().toString(),
      name: name,
      phone: phone,
    );

    if (index != -1) {
      setState(() {
        widget.lista[index] = newContact;
      });
    } else {
      setState(() {
        widget.lista.insert(0, newContact);
      });
    }
    Navigator.of(context).pop();
  }

  _removeContact(String id) {
    setState(() {
      widget.lista.removeWhere((element) => element.id == id);
    });
  }

  _openContactFormModal(BuildContext context,
      [String id = "", int index = -1]) {
    final List<Contact> result = id.isEmpty ? [] : [widget.lista[index]];

    showModalBottomSheet(
      context: context,
      builder: (_) {
        return ContactForm(
          onSubmit: _updateContact,
          listContact: result,
          index: index,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    bool dataOk = widget.lista.isEmpty;

    final mediaQuery = MediaQuery.of(context);

    final PreferredSizeWidget appBar = AppBar(
      title: const Text("Contatos"),
      actions: [],
    );

    final availableHeight = mediaQuery.size.height -
        appBar.preferredSize.height -
        mediaQuery.padding.top;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Meus Contatos"),
        ),
        body: widget.lista.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const FittedBox(
                      child: Text(
                        "Não há contatos a serem exibidos",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : SizedBox(
                height: availableHeight * 0.8,
                child: ContactItem(
                  listContact: widget.lista,
                  onRemove: _removeContact,
                  onOpenForm: _openContactFormModal,
                ),
              ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _openContactFormModal(context),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
