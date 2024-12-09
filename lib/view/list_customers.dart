import 'package:flutter/material.dart';
import '../models/customer.dart';
import '../components/custom_item.dart';
import '../data/dummy_data.dart';

class ListCustomers extends StatelessWidget {
  const ListCustomers({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Customer> listCustomers = dummyCustomer.toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Listagem de Clientes"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => print("Teste"),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            InkWell(
              child: CustomItem(listCustomer: listCustomers),
            )
          ],
        ),
      ),
    );
  }
}
