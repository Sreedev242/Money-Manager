import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:personal_money_management_app/Models/category/categorymodel.dart';
import 'package:personal_money_management_app/Models/category/transactionmodel.dart';

ValueNotifier<List<CategoryModel>> incomecategorynotifier = ValueNotifier([]);

ValueNotifier<List<CategoryModel>> expensecategorynotifier = ValueNotifier([]);

ValueNotifier<List<TransactionModel>> TransactionNotifierlist =
    ValueNotifier([]);

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
  for (var category in boxlist) {}

  await Future.forEach(boxlist, (CategoryModel category) {
    //to check each data of yhe list
    if (category.catType == CategoryType.income) {
      incomecategorynotifier.value.add(category);
    } else {
      expensecategorynotifier.value.add(category);
    }
  });
  incomecategorynotifier.notifyListeners();
  expensecategorynotifier.notifyListeners();
}

// Following is to get items from Add transaction

Future getTransaction() async {
  final namebox = await Hive.openBox<TransactionModel>('trans');
  final boxlist = await namebox.values.toList();
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
