import 'package:flutter/material.dart';
import 'package:personal_money_management_app/Models/category/categorymodel.dart';
import 'package:intl/intl.dart';
import '../Models/category/transactionmodel.dart';
import '../functions.dart';

class TransactionScreen extends StatelessWidget {
  const TransactionScreen({super.key});


  @override
  Widget build(BuildContext context) {
    getTransaction();
    getcategory();
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 199, 243, 201),
      body: ValueListenableBuilder(
        valueListenable:TransactionNotifierlist ,
        builder: (BuildContext context, List<TransactionModel> TransList, Widget?_) { return
           ListView.separated(
            itemBuilder: ((context, index) {
              final Trans=TransList[index];
              return Card(
                child: Padding(
                  padding:  EdgeInsets.all(8.0),
                  child: ListTile(
                    leading:  CircleAvatar(
                      radius: 50,
                      backgroundColor: Trans.tranType==CategoryType.income? 
                      Color.fromARGB(225, 138, 232, 143)
                      :Color.fromARGB(255, 255, 181, 181),
                      child: Text(
                        '${DateFormat.MMMd().format(Trans.date).split(' ').last}\n${DateFormat.MMMd().format(Trans.date).split(' ').first}' 
                        
                        ),

                      ),
                    title: Text('Rs ${Trans.Amount}'),
                    subtitle: Text(Trans.categotyItem.name??''),
                  ),
                ),
              );
      
            }),
            separatorBuilder: ((context, index) {
              return SizedBox(height: 12,);
            }),
            itemCount: TransactionNotifierlist.value.length);
        },
      
      )
    );
  }

}
