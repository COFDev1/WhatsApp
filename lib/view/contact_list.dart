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
  final String url = "http://192.168.10.101:3001/contatos/";
  String filter = "";
  bool allOk = false;

  @override
  void initState() {
    super.initState();

    _list(id: "7");
  }

  Future<bool> _list({String id = ""}) async {
    final response = await http.get(Uri.parse(url + "${id}"));

    allOk = response.statusCode == 200;

    if (allOk) {
      final List list;

      final data = jsonDecode(response.body);

      list = data is Map ? [jsonDecode(response.body)] : data;

      widget.lista = [];

      list.forEach((element) {
        widget.lista.add(Contact(
          id: element["id"],
          name: element["name"],
          phone: element["phone"],
        ));
        print("Elemento: $element");
      });

      setState(() {});
    }
    return allOk;
  }

  _update() {}

  Future<bool> _updateDataContactApi(
      {int type = 1, Map<String, dynamic>? req}) async {
    // bool allOk = false;

    Map<String, String> structDefault = {
      'Content-Type': 'application/json',
    };

    // var url = "http://192.168.10.101:3001/contatos/";

    widget.lista = [];

    switch (type) {
      case 1:
        final response = await http.get(Uri.parse(url));

        // allOk = response.statusCode == 200;

        // if (allOk) {
        var data = jsonDecode(response.body);

        //   data.forEach((element) {
        //     widget.lista.add(Contact(
        //       id: element["id"],
        //       name: element["name"],
        //       phone: element["phone"],
        //     ));
        //   });

        //   setState(() {});
        // }
        break;

      case 2:
        var resBody = {};
        resBody["name"] = "Carlinho da Silva";
        resBody["phone"] = "27999405610";
        resBody["tipo"] = "Celular";
        resBody["descricao"] = "Secretaria";

        print(jsonEncode(resBody));

        // final response = await http.put(Uri.parse(url + "9"), body: jsonEncode(resBody));
        final response =
            await http.post(Uri.parse(url), body: jsonEncode(resBody));

        allOk = response.statusCode == 200 || response.statusCode == 201;

        if (allOk) {
          var data = jsonDecode(response.body);
          print("Retorno ${response.body}");
        }
        break;

      case 3:
        final response = await http.delete(Uri.parse(url));

        allOk = response.statusCode == 200;

        if (allOk) {
          setState(() {});
        }
        break;
    }
    return allOk;
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
