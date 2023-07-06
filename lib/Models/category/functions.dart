import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:personal_money_management_app/Models/category/categorymodel.dart';

ValueNotifier<List<CategoryModel>>incomecategorynotifier=ValueNotifier([]);

ValueNotifier<List<CategoryModel>>expensecategorynotifier=ValueNotifier([]);

const String boxname='xbox';

Future<void>insertCategory(CategoryModel value)async{
  final namebox=await Hive.openBox<CategoryModel>(boxname);
  namebox.add(value);
}
// Following fuction is to display on ui when new data is added

Future getcategory()async{
    final namebox=await Hive.openBox<CategoryModel>(boxname);
   final boxlist= namebox.values.toList();
   incomecategorynotifier.value.clear();
   expensecategorynotifier.value.clear();
  await  Future.forEach
      (boxlist, (CategoryModel category) {   //to check each data of yhe list
    if (category.type==CategoryType.income) {
      incomecategorynotifier.value.add(category);
    }
    else{
      expensecategorynotifier.value.add(category);
    }
  }
  );
  incomecategorynotifier.notifyListeners();
  expensecategorynotifier.notifyListeners();
}

// Following fucnts is to Delete the category from list

// Future deleteCategory(int id)async{
//     // final namebox=await Hive.openBox<CategoryModel>(boxname);
// }




