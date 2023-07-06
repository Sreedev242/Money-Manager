import 'package:flutter/material.dart';
import 'package:personal_money_management_app/Home/Homescreen.dart';

class bottomNavigationBar extends StatelessWidget {
  const bottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Homescreen.selectedindex,
      builder: (BuildContext, int updatedIndex, Widget?_) {
       return BottomNavigationBar(items:  [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Transaction'),
            BottomNavigationBarItem(
              icon: Icon(Icons.category),
              label: 'Category',
              
            ),
        ],onTap: (newindex){
        Homescreen.selectedindex.value=newindex;
        },
        currentIndex: updatedIndex,
        );
      },
      
    );
  }
}