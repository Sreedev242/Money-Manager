import 'package:flutter/material.dart';
import 'package:personal_money_management_app/functions.dart';

import '../Models/category/categorymodel.dart';

class expenselistview extends StatelessWidget {
  const expenselistview({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: expensecategorynotifier, 
      builder: (BuildContext context, List<CategoryModel> newcategoryexpense, Widget?_){
        return  Padding(
          padding: const EdgeInsets.only(bottom: 60),
          child: ListView.separated(
              itemBuilder: (ctx,index){
          final exp=newcategoryexpense[index];
        
              return Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            
            child: ListTile( tileColor: Color.fromARGB(255, 248, 223, 223),
            
              title: Text(exp.name??""),
              trailing: IconButton(onPressed: (){
                // delete item frm expense
                deleteExpenseCategory(exp.id??'');
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
            itemCount: newcategoryexpense.length,),
        );
      });
  }
}