import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:whatsappcentral/models/autenticacao.dart';
import '../models/customer.dart';
import '../components/custom_item.dart';
import '../view/logins_screen.dart';
import 'dart:convert';

class ListCustomers extends StatefulWidget {
  final String token;
  final String sales;

  const ListCustomers({
    required this.token,
    required this.sales,
    super.key,
  });

  @override
  State<ListCustomers> createState() => _ListCustomersState();
}

class _ListCustomersState extends State<ListCustomers> {
  final List<Customer> listCustomers = [];

  bool loading = false;

  @override
  void initState() {
    super.initState();

    setState(() => loading = true);

    loadCustomer();
  }

  Future<void> loadCustomer() async {
    String token = widget.token;
    String saller = widget.sales;

    Map<String, String> request = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    final response =
        await http.get(Uri.parse(Autenticacao.urlCustomers + saller), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });

    print("Lendo os dados do produto $response");

    if (response.body == 'null') return;
    Map<String, dynamic> data = jsonDecode(response.body);

    data["items"].forEach((element) {
      listCustomers.add(
        Customer(
          id: element["codigo"],
          name: element["nome"],
          whatsapp: element["tel"],
        ),
      );
    });

    if (listCustomers.isNotEmpty) {
      setState(() => loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    // final List<Customer> listCustomers = dummyCustomer.toList();
    final mediaQuery = MediaQuery.of(context);
    final PreferredSizeWidget appBar = AppBar(
      title: const Text("Listagem de Clientes"),
      actions: [
        IconButton(
          icon: const Icon(Icons.logout),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => LoginPage(),
              ),
            );
          },
        )
      ],
    );
    final availableHeight = mediaQuery.size.height -
        appBar.preferredSize.height -
        mediaQuery.padding.top;

    return SafeArea(
      child: Scaffold(
        appBar: appBar,
        body: Column(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: (loading)
                    ? [
                        const Center(
                          child: Padding(
                            padding: EdgeInsets.all(16),
                            child: SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ),
                        const Text("Aguarde...Carregando os clientes..."),
                      ]
                    : [
                        SizedBox(
                          height: availableHeight * 0.9,
                          child: InkWell(
                            child: CustomItem(listCustomer: listCustomers),
                          ),
                        ),
                        SizedBox(
                          height: availableHeight * 0.1,
                          child: FloatingActionButton(
                            onPressed: () => print("Ok..."),
                            elevation: 5,
                            child: const Icon(Icons.add),
                          ),
                        ),
                      ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
