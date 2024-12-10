import 'package:flutter/material.dart';
import '../components/controlaUsuario.dart';
import '../models/autenticacao.dart';
import 'package:http/http.dart' as http;
import 'list_customers.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final List<ListCustomers> _listCustomers = [];

  void geraTokenProtheus() async {
    const url = 'http://192.168.2.12:8083/rest/app/customers/123';
    String token = '';

    // Navigator.pushReplacement(
    //     context,
    //     MaterialPageRoute(
    //         builder: (BuildContext context) => const ListCustomers()));

    // // Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => const ListaClientesScreen()));

    ControlaUsuario conexao = ControlaUsuario();

    await conexao.getToken().then((value) => token = value);

    print("Token: ${token}");

    Map<String, String> request = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    final response = await http
        .get(
          Uri.parse('http://192.168.2.12:8083/rest/app/customers/123'),
          headers: request,
          // body: jsonEncode(infoCustomer),
        )
        .then((_) => print("Passou aqui agora.... ${token}"));

    // // token = conexao.conectaProtheus() as String;
    // conexao.conectaProtheus().then((value) {

    //     token = value;

    //     if (token.isNotEmpty){
    //       Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => const ListCustomers()));
    //     }
    // });

    // print("Tipo retornado : ${conexao.conectaProtheus().runtimeType}");

    // print("Passou aqui ${token}");

    // if (token.isEmpty){

    // }else{
    //     // Navigator.pushReplacement(;
    //     // Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => const ListaClientesScreen()));

    // }
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
                  keyboardType: TextInputType.text,
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
