

import 'package:flutter/material.dart';
import 'package:personal_money_management_app/Models/category/categorymodel.dart';
import 'package:personal_money_management_app/Models/category/functions.dart';

  ValueNotifier selectedcategorynotifier=ValueNotifier(CategoryType.income);
  TextEditingController _ctrladdcategory=TextEditingController();

Future<void> showdialogueBox(BuildContext context) async {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Color.fromARGB(255, 209, 247, 210),
          content: Container(
            height: 170,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  TextFormField(
                    controller: _ctrladdcategory,
                    decoration: const InputDecoration(
                        hintText: 'Add Category', border: OutlineInputBorder()),
                  ),const SizedBox(
                    height: 12,
                  ),
                 Row(
                  children: [
                        // Radioofbox(),
                        Radioofbox(categoryname: 'Income', type: CategoryType.income),
                        gapBetween(27),
                        Radioofbox(categoryname: 'Expense', type: CategoryType.expense),
                  ],
                ),
                  
                  const SizedBox(
                    height: 16,
                  ),
                  ElevatedButton(onPressed: () {
                  // Add category
                  final _name=_ctrladdcategory.text;
                if (_name.isEmpty) {
                  return
                  Navigator.of(context).pop();
                 
                }else{

                insertCategory(CategoryModel(
                  name: _name, 
                  type: selectedcategorynotifier.value,
                   id: DateTime.now().millisecondsSinceEpoch.toString(),));
                   getcategory();
                 
                  }Navigator.of(context).pop();
                  },
                   child: const Text('Add'))
                ],
              ),
            ),
          ),
        );
      });
}

class Radioofbox extends StatelessWidget {
  final String categoryname;
  final CategoryType type;
  
   Radioofbox(
    {super.key,
  required this.categoryname,required this.type
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ValueListenableBuilder(
          valueListenable: selectedcategorynotifier,
         builder: (BuildContext, dynamic newvalue, Widget?_){
          return Radio(
          value: type,
          groupValue: newvalue,
          onChanged: (xxx){
              selectedcategorynotifier.value=xxx;
              selectedcategorynotifier.notifyListeners();
          },
        );
        }),
        Text(categoryname)
      ],
    );
  }
}



// Following function is to provide gap b/w two Radios.
gapBetween(double gapwidth){
  return SizedBox(width: gapwidth,);
}
