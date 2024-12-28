import 'package:flutter/material.dart';
import 'package:whatsappcentral/components/contact_form.dart';
import 'package:whatsappcentral/components/contact_item.dart';
import 'package:whatsappcentral/models/contact.dart';
import 'dart:math';

class ListContacts extends StatefulWidget {
  List<Contact> lista;

  ListContacts({required this.lista, super.key});

  @override
  State<ListContacts> createState() => _ListContactsState();
}

class _ListContactsState extends State<ListContacts> {
  @override
  void initState() {
    super.initState();

    widget.lista = [
      Contact(
        id: 'c1',
        name: 'Jose',
        phone: '111245458',
      ),
      Contact(
        id: 'c2',
        name: 'Pedro',
        phone: '124882-458',
      ),
      Contact(
        id: 'c3',
        name: 'Pedro Souza',
        phone: '124882-458',
      ),
    ].toList();
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

  List<Contact> _getContactById(String id) {
    return (widget.lista.where((element) => element.id == id)).toList();
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
