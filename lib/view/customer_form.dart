import 'package:flutter/material.dart';
import 'package:whatsappcentral/models/customer.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class CustomerForm extends StatefulWidget {
  Customer customer;

  CustomerForm({required this.customer, super.key});

  @override
  State<CustomerForm> createState() => _CustomerFormState();
}

class _CustomerFormState extends State<CustomerForm> {
  late final name = TextEditingController(text: widget.customer.name);
  late final whastApp = TextEditingController(text: widget.customer.whatsapp);

  void _save(Map<String, String> infoCustomer) async {
    const url = 'http://192.168.2.12:8083/rest/app/customers/';
    const String token =
        "eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6InBKd3RQdWJsaWNLZXlGb3IyNTYifQ.eyJpc3MiOiJUT1RWUy1BRFZQTC1GV0pXVCIsInN1YiI6Implc3NlIiwiaWF0IjoxNzMzNzQ4NTQwLCJ1c2VyaWQiOiIwMDAwNjEiLCJleHAiOjE3MzM3NTIxNDAsImVudklkIjoiUDEyXzMzX0hPTSJ9.bFpyvV8EniPlROwOTCxMt6o2tDA6V5MdH8WQy3O8E6JH2f_f6PcqVWtlnXmOs-nUN4PaGoZPtmPBA_blU1PQwbELF8FuHQD9oHPZmeLPXQC7e85llhPteG_h522d3pMv10Bi-1q1uRJn-D735Ri7aA9tZ67e-nrX-h7hBQdBsAQeIEdNL99z1u7FWviEWVkOdL8hF1iZLkGFgwemCl7FL-6vrp0rHzV2h0SNgFxmd90DHyzJx3kUcbuHgr8uih6_y5MsPmAmLTI4XieXRtY6ja64rF6blghDZro2tkGQuyUE7LmR0b4zTs7PjBlO6NS5GzdzbhurfjDG4TBW90eb6g";

    Map<String, String> request = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    final response = await http
        .post(
      Uri.parse(url),
      headers: request,
      body: jsonEncode(infoCustomer),
    )
        .then((_) {
      print("Passou aqui agora....");
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.customer.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: TextField(
                controller: name,
                onSubmitted: (_) => {},
                decoration: InputDecoration(labelText: 'Nome'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: TextField(
                controller: whastApp,
                onSubmitted: (_) => {},
                decoration: InputDecoration(labelText: 'WhatsApp'),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  ElevatedButton(
                    child: Text(
                      "Gravar",
                      style: TextStyle(
                        color: Theme.of(context).textTheme.button?.color,
                      ),
                    ),
                    onPressed: () {
                      Map<String, String> dataCustomer = {};
                      dataCustomer["id"] = widget.customer.id;
                      dataCustomer["name"] = name.text;
                      dataCustomer["whatasApp"] = whastApp.text;
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Processing Data...')),
                      );
                      return _save(dataCustomer);
                    },
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
