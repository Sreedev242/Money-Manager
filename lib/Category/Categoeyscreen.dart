import 'package:flutter/material.dart';
import 'package:personal_money_management_app/Category/expense_listview.dart';
import 'package:personal_money_management_app/Category/income_listviw.dart';
import 'package:personal_money_management_app/Models/category/functions.dart';

class categoryscreen extends StatefulWidget {
  const categoryscreen({super.key});

  @override
  State<categoryscreen> createState() => _categoryscreenState();
}

class _categoryscreenState extends State<categoryscreen> with SingleTickerProviderStateMixin {

late final TabController _tabcontroller=TabController(length: 2, vsync:this);

@override
  void initState() {
    _tabcontroller;
    getcategory();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TabBar(controller: _tabcontroller,
            tabs: [
           Tab(text: 'Income'),
             Tab(text: 'Expense')
          ],

          ),
          Expanded(
            child: TabBarView(
              controller: _tabcontroller,
              children: [
              
              incomelistview(),
              expenselistview()
            ]
            ),
          )
        ],
      )
    );
  }
}