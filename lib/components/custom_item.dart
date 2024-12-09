import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import '../models/customer.dart';
import '../view/customer_form.dart';

class CustomItem extends StatelessWidget {
  final List<Customer> listCustomer;

  const CustomItem({required this.listCustomer, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: (MediaQuery.of(context).size.height) * 0.8,
      child: listCustomer.isEmpty
          ? Column(
              children: [
                const SizedBox(height: 20),
                Text(
                  'Nenhuma cliente associado!',
                  style: Theme.of(context).textTheme.headline6,
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 200,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            )
          : Container(
              color: Colors.grey[200],
              padding: EdgeInsets.all(10),
              child: ListView.builder(
                itemCount: listCustomer.length,
                itemBuilder: (ctx, index) {
                  final tr = listCustomer[index];
                  return Card(
                    elevation: 5,
                    margin: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 5,
                    ),
                    child: ListTile(
                        leading: IconButton(
                          icon: const Icon(
                            Icons.account_circle_rounded,
                            size: 30,
                          ),
                          color: Theme.of(context).errorColor,
                          onPressed: () {},
                        ),
                        title: Text(
                          tr.name,
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        subtitle: Text(
                          tr.whatsapp,
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.arrow_forward_ios),
                          color: Theme.of(context).errorColor,
                          onPressed: () {},
                        ),
                        iconColor: Colors.white,
                        textColor: Colors.black,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => CustomerForm(customer: tr),
                            ),
                          );
                        }),
                  );
                },
              ),
            ),
    );
  }
}
