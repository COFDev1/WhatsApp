import 'package:flutter/material.dart';
import '../components/controlaUsuario.dart';
import '../models/autenticacao.dart';
import 'package:http/http.dart' as http;
import 'list_customers.dart';
import 'dart:convert';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final List<ListCustomers> _listCustomers = [];

  late final login = TextEditingController();
  late final password = TextEditingController();

  void geraTokenProtheus() async {
    const url = 'http://192.168.2.12:8083/rest/app/customers/123';
    String token = '';

    // Navigator.pushReplacement(
    //     context,
    //     MaterialPageRoute(
    //         builder: (BuildContext context) => const ListCustomers()));

    // // Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => const ListaClientesScreen()));

    ControlaUsuario conexao = ControlaUsuario();

    try {
      token = await conexao.conectaProtheus();

      if (token.isNotEmpty) {
        print("Token gerado  com sucesso:  ${token}");
      } else {
        throw Exception();
      }
    } catch (e) {
      throw showDialog<void>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text("Ocorreu um erro!"),
          content: const Text("Falha ao autenticar"),
          actions: [
            TextButton(
              child: const Text("Ok"),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      );
    }

    print("Token gerado: ${token}");

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => const ListCustomers(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue[100],
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const TextField(
                  autofocus: true,
                  keyboardType: TextInputType.number,
                  style: TextStyle(color: Colors.blue, fontSize: 30),
                  decoration: InputDecoration(
                    labelText: "Usuário",
                    labelStyle: TextStyle(color: Colors.black),
                  ),
                ), //TextField
                const Divider(),
                const TextField(
                    autofocus: true,
                    obscureText: true,
                    keyboardType: TextInputType.text,
                    style: TextStyle(color: Colors.blue, fontSize: 30),
                    decoration: InputDecoration(
                      labelText: "Senha",
                      labelStyle: TextStyle(color: Colors.black),
                    )), //TextField
                const Divider(),
                ElevatedButton(
                  onPressed: geraTokenProtheus,
                  child: const Text(
                    "Entrar",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
