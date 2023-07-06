import 'package:flutter/material.dart';

class TransactionScreen extends StatelessWidget {
  const TransactionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 199, 243, 201),
      body: ListView.separated(
          itemBuilder: ((context, index) {
            return Card(
              child: Padding(
                padding:  EdgeInsets.all(8.0),
                child: ListTile(
                  leading:  CircleAvatar(
                    radius: 50,
                    child: Text('25 jun')),
                  title: Text('10000'),
                  subtitle: Text('Travel$index'),
                ),
              ),
            );

          }),
          separatorBuilder: ((context, index) {
            return SizedBox(height: 12,);
          }),
          itemCount: 15),
    );
  }
}
