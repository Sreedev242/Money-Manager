import 'package:flutter/material.dart';
import 'package:personal_money_management_app/Models/category/functions.dart';

import '../Models/category/categorymodel.dart';

class expenselistview extends StatelessWidget {
  const expenselistview({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: expensecategorynotifier, 
      builder: (BuildContext context, List<CategoryModel> newcategoryexpense, Widget?_){
        return  ListView.separated(
      itemBuilder: (ctx,index){
        final exp=newcategoryexpense[index];
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          
          child: ListTile( tileColor: const Color.fromARGB(255, 223, 248, 224),
          
            title: Text(exp.name ?? ''),
            trailing: IconButton(onPressed: (){
              // delete item frm expense
              
            }, icon: Icon(Icons.delete)),
          ),
        ),
      );
      }, 
    separatorBuilder: (ctx,index){
      return SizedBox(
        height: 12,
      );
    }, 
    itemCount: newcategoryexpense.length,);
      });
  }
}