import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:whatsappcentral/models/contact.dart';

class ContactItem extends StatefulWidget {
  final List<Contact> listContact;

  ContactItem({required this.listContact, super.key});

  @override
  State<ContactItem> createState() => _ContactItemState();
}

class _ContactItemState extends State<ContactItem> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constraints) {
      return Container(
        height: constraints.maxHeight,
        child: ListView.builder(
          itemCount: widget.listContact.length,
          itemBuilder: (ctx, index) {
            final tr = widget.listContact[index];
            print("Valor do indice ${index}");
            return Card(
              elevation: 5,
              margin: const EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 5,
              ),
              child: ListTile(
                  leading: Padding(
                    padding: const EdgeInsets.all(6),
                    child: FittedBox(
                      child: Text(
                        'R\$${tr.id}',
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  title: Text(
                    tr.name,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  subtitle: Text("Teste"),
                  trailing: MediaQuery.of(context).size.width > 480
                      ? TextButton.icon(
                          onPressed: () => print("ok"),
                          icon: Icon(Icons.delete,
                              color: Theme.of(context).errorColor),
                          label: Text(
                            "Excluir",
                            style:
                                TextStyle(color: Theme.of(context).errorColor),
                          ),
                        )
                      : IconButton(
                          icon: const Icon(Icons.delete),
                          color: Theme.of(context).errorColor,
                          onPressed: () => print("ok"),
                        )),
            );
          },
        ),
      );
    });
  }
}
