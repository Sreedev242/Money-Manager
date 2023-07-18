import 'package:flutter/material.dart';
import 'package:personal_money_management_app/Category/Categoeyscreen.dart';
import 'package:personal_money_management_app/Home/Widgets/Bottomnavi_.dart';
import 'package:personal_money_management_app/Transactions/Transactionscreen.dart';
import 'package:personal_money_management_app/Transactions/add_transactionscreen.dart';
import 'package:personal_money_management_app/functions.dart';

import '../Models/category/category_dialogbox.dart';

class Homescreen extends StatelessWidget {
   Homescreen({super.key});

  static ValueNotifier<int> selectedindex=ValueNotifier(0);

  final _pages=[
    TransactionScreen(),
    categoryscreen()
  ];

  @override
  Widget build(BuildContext context) {
  
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 78, 211, 84),
        appBar: AppBar(
          backgroundColor:Color.fromARGB(255, 98, 212, 104),
          title: Text('Money Manager'),
          centerTitle: true,
        ),
        bottomNavigationBar: bottomNavigationBar(),
        
        body: SafeArea(child: 
          ValueListenableBuilder(
            valueListenable: selectedindex, 
            builder: (BuildContext, int updatedIndex, Widget?_){
              return _pages[updatedIndex];
            })
    
        ),
        floatingActionButton: FloatingActionButton(onPressed: (){
          if (selectedindex.value==0) {
            
            print('Add Transaction');
            Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
              return addTransactionscreen();
            }));
          }
          else{
            print('add category');
             showdialogueBox(context);
          }
       

        },
        child: Icon(Icons.add),),
      ),
    );
  }
}