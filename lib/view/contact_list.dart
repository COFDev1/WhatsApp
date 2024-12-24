import 'package:flutter/material.dart';
import 'package:whatsappcentral/components/contact_form.dart';
import 'package:whatsappcentral/components/contact_item.dart';
import 'package:whatsappcentral/data/dummy_data.dart';
import 'package:whatsappcentral/models/contact.dart';

class ListContacts extends StatelessWidget {
  List<Contact> lista;

  ListContacts({
    required this.lista,
    super.key,
  });

  _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return ContactForm();
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

    lista = [
      Contact(
        id: '00981010',
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
        name: 'Maria',
        phone: '4567896879',
      ),
      Contact(
        id: 'c4',
        name: 'Amaral Santos',
        phone: '45215455',
      ),
      Contact(
        id: 'c5',
        name: 'Caio Santos',
        phone: '452457565',
      ),
      Contact(
        id: 'c6',
        name: 'Tatiane Silva',
        phone: '457878528',
      ),
      Contact(
        id: 'c7',
        name: 'Sonia Costa',
        phone: '4567879897',
      ),
      Contact(
        id: 'c8',
        name: 'Antonio Augusto',
        phone: '456788258',
      ),
      Contact(
        id: 'c9',
        name: 'Jorge Alves',
        phone: '456788258',
      ),
    ];

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Meus Contatos"),
        ),
        body: lista.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FittedBox(
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
                child: ContactItem(listContact: lista),
              ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _openTransactionFormModal(context),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
