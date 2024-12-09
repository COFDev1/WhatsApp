import 'package:http/http.dart' as http;
import 'package:whatsappcentral/models/autenticacao.dart';
import 'package:flutter/material.dart';
import 'package:whatsappcentral/models/customer.dart';
import 'dart:async';

class ControlaUsuario {
  Future<String> conectaProtheus() async {
    var response = await http.post(Uri.parse(Autenticacao.url));

    if (response.statusCode == 201) {
      return response.body;
    } else {
      return "";
    }
  }

  String getToken() {
    String token = this.conectaProtheus().toString();

    return token;
  }

  bool validDataUsrer(String usuario, String senha) {
    return true;
  }

  // Future<String> updateDataCustomer(Customer customer) async {
  //   final response = await http.post(
  //     Uri.parse('https://jsonplaceholder.typicode.com/albums'),
  //     headers: <String, String>{
  //       'Content-Type': 'application/json; charset=UTF-8',
  //     },
  //     body: jsonEncode(<String, String>{
  //       'title': title,
  //     }),
  //   );

  //   if (response.statusCode == 201) {
  //     // If the server did return a 201 CREATED response,
  //     // then parse the JSON.
  //     return Album.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  //   } else {
  //     // If the server did not return a 201 CREATED response,
  //     // then throw an exception.
  //     throw Exception('Failed to create album.');
  //   }
  // }
}
