import 'package:flutter/material.dart';
import 'package:personal_money_management_app/functions.dart';

import '../Models/category/categorymodel.dart';

class incomelistview extends StatelessWidget {
  const incomelistview({super.key});

  @override
  Widget build(BuildContext context) {
  
    return ValueListenableBuilder(
      valueListenable: incomecategorynotifier,
       builder: (BuildContext, List<CategoryModel>newcategoryincome, Widget?_){
        return Padding(
          padding: const EdgeInsets.only(bottom: 70),
          child: ListView.separated(
              itemBuilder: (ctx,index){
          final inc=newcategoryincome[index];
              return Card(
          child: Padding(
            padding:  EdgeInsets.only(left: 8,right: 8,top: 8,bottom: 8),
            child: ListTile(
            
              tileColor: Color.fromARGB(255, 223, 248, 224),
              
              title: Text(inc.name??''),
              trailing: IconButton(onPressed: (){
                // delete item frm incom
                
                deleteIncomeCategory(inc.id??'');
               
              }, icon: const Icon(Icons.delete)),
            ),
          ),
              );
              }, 
            separatorBuilder: (ctx,index){
              return  SizedBox(
          height: 12,
          
          
              );
            }, 
            itemCount:newcategoryincome.length,),
        );
       });
  }
}