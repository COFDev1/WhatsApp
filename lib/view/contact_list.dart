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
    print("Pasou aqui agora");
    _list();
  }

  Future<bool> _list({String id = ""}) async {
    final response = await http.get(Uri.parse(url + "${id}"));

    allOk = response.statusCode == 200;

    if (allOk) {
      final List newList;

      final data = jsonDecode(response.body);

      newList = data is Map ? [jsonDecode(response.body)] : data;

      widget.lista = [];

      newList.forEach((element) {
        widget.lista.add(
          Contact(
              id: element["id"],
              name: element["name"],
              phone: element["phone"],
              type: element["tipo"],
              description: element["descricao"]),
        );
      });
      print("Lista de itens: ${widget.lista}");
      setState(() {});
    }
    return allOk;
  }

  Future<bool> _delete({String id = ""}) async {
    final response = await http.delete(Uri.parse(url + "${id}"));

    allOk = response.statusCode == 200;

    return allOk;
  }

  void _updateContact(String name, String phone, int index, String type,
      String description, int operation) {
    final newContact = Contact(
      id: widget.lista[index].id,
      name: name,
      phone: phone,
      type: type,
      description: description,
    );

    switch (operation) {
      case 3:
        break;
      case 4:
        break;
      case 5:
        FutureBuilder<bool>(
          future: _delete(id: widget.lista[index].id),
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (snapshot.data == false) {
              return const CircularProgressIndicator();
            } else {
              return Text("Operação realizada com sucesso!!!!");
            }
          },
        );

        break;
      default:
        // statementn;
        break;
    }
    // if (index != -1) {
    //   setState(() {
    //     widget.lista[index] = newContact;
    //   });
    // } else {
    //   setState(() {
    //     widget.lista.insert(0, newContact);
    //   });
    // }
    // Navigator.of(context).pop();
  }

  _removeContact(String id) {
    setState(() {
      widget.lista.removeWhere((element) => element.id == id);
    });
  }

  _openContactFormModal(BuildContext? context,
      [String id = "", int index = -1, int operation = 3]) {
    final List<Contact> result = id.isEmpty ? [] : [widget.lista[index]];

    showModalBottomSheet(
      context: context!,
      builder: (_) {
        return ContactForm(
          onSubmit: _updateContact,
          listContact: result,
          index: index,
          operation: operation,
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
