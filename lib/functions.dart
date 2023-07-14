import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:personal_money_management_app/Models/category/categorymodel.dart';
import 'package:personal_money_management_app/Models/category/transactionmodel.dart';

ValueNotifier<List<CategoryModel>> incomecategorynotifier = ValueNotifier([]);

ValueNotifier<List<CategoryModel>> expensecategorynotifier = ValueNotifier([]);

ValueNotifier<List<TransactionModel>> TransactionNotifierlist =
    ValueNotifier([]);
CategoryModel? y;

const String boxname = 'xbox';

Future<void> insertCategory(CategoryModel value) async {
  final namebox = await Hive.openBox<CategoryModel>(boxname);
  namebox.add(value);
}
// Following fuction is to display on ui when new data is added

Future getcategory() async {
  final namebox = await Hive.openBox<CategoryModel>(boxname);
  final boxlist = await namebox.values.toList();
  incomecategorynotifier.value.clear();
  expensecategorynotifier.value.clear();
  await Future.forEach(boxlist, (CategoryModel category) {
    
    if (category.catType == CategoryType.income) {
      incomecategorynotifier.value.add(category);
    } else {                                             //to check each data of yhe list
      expensecategorynotifier.value.add(category);
    }
  });
  incomecategorynotifier.notifyListeners();
  expensecategorynotifier.notifyListeners();
}



//  Following is to delete IncomeCategory Item

Future deleteIncomeCategory(String xID)async{
   final namebox = await Hive.openBox<CategoryModel>(boxname);
  await namebox.delete(xID);
   incomecategorynotifier.value.removeWhere((element) => element.id==xID);

   incomecategorynotifier.notifyListeners();
  
}

//  Following is to delete expenseCategory Item

Future<void>  deletexpenseCategory(String xID)async{
   final namebox = await Hive.openBox<CategoryModel>(boxname);
  await namebox.delete(xID);
   expensecategorynotifier.value.removeWhere((element) => element.id==xID);
   expensecategorynotifier.notifyListeners();
}

// Following is to get items from Add transaction

Future getTransaction() async {
  final transBox = await Hive.openBox<TransactionModel>('trans');
  final boxlist = await transBox.values.toList();
  boxlist.sort(
    (First, Second) {
      return Second.date
          .compareTo(First.date); //This is to make list ascending wrt Date
    },
  );
  TransactionNotifierlist.value.clear();
  TransactionNotifierlist.value.addAll(boxlist);
  TransactionNotifierlist.notifyListeners();
}
