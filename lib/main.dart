import 'package:flutter/material.dart';
import 'view/logins_screen.dart';
import 'view/list_customers.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // Print();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const Login(), // ListCustomers()
        debugShowCheckedModeBanner: false);
  }
}
