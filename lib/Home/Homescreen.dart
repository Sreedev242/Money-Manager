import 'package:flutter/material.dart';
import 'package:personal_money_management_app/Category/Categoeyscreen.dart';
import 'package:personal_money_management_app/Home/Widgets/Bottomnavi_.dart';
import 'package:personal_money_management_app/Home/Widgets/loginscreen.dart';
import 'package:personal_money_management_app/Transactions/Transactionscreen.dart';
import 'package:personal_money_management_app/Transactions/add_transactionscreen.dart';
import 'package:personal_money_management_app/functions.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
          actions: [
            IconButton(tooltip:'Sign out',
            onPressed: ()async{
              final _sharedprefs=await SharedPreferences.getInstance();
            await  _sharedprefs.clear();
                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context){
                  return LoginScreen();
                }), (route) => false);
              
            },
             icon: Icon(Icons.logout_outlined))
          ],
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