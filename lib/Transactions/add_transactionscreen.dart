import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';
import 'package:personal_money_management_app/Models/category/category_dialogbox.dart';
import 'package:personal_money_management_app/Models/category/categorymodel.dart';
import 'package:personal_money_management_app/functions.dart';
import 'package:personal_money_management_app/Models/category/transactionmodel.dart';

//  String? valueOfselectedItem='';

ValueNotifier selectedradio = ValueNotifier(CategoryType.income);
ValueNotifier<DateTime?> selectdDatevalue = ValueNotifier(null);
ValueNotifier<CategoryModel?> selectedDropdownValue = ValueNotifier(null);

CategoryModel? cccc;
CategoryModel? _selectedCategoryItem;

TextEditingController ctrlpurpose = TextEditingController();
TextEditingController ctrlamount = TextEditingController();

class addTransactionscreen extends StatelessWidget {
  addTransactionscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 217, 235, 218),
      appBar: AppBar(
        title: const Text('Add Transaction'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 98, 212, 104),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextFormField(
                controller: ctrlpurpose,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), hintText: 'Purpose'),
              ),
              SizedBox(
                height: 5,
              ),
              TextField(
                controller: ctrlamount,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Amount',
                ),
              ),
              SizedBox(
                height: 20,
              ),

              // Date

              ValueListenableBuilder(
                  valueListenable: selectdDatevalue,
                  builder:
                      (BuildContext context, DateTime? chosenDate, Widget? _) {
                    final String date;
                    if (chosenDate == null) {
                      date = 'Select Date';
                    } else {
                      date = DateFormat('dd-MMM-yyyy')
                          .format(chosenDate)
                          .toString();
                    }
                    return TextButton.icon(
                        onPressed: () async {
                          final datex = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2022),
                              lastDate: DateTime.now());
                          selectdDatevalue.value = datex;
                          selectdDatevalue.notifyListeners();
                        },
                        icon: Icon(Icons.calendar_month),
                        label: Text(date));
                  }),
              SizedBox(
                height: 20,
              ),

              //  Radio
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const RadioOfTransactionpage(
                      categoryname: 'Income', type: CategoryType.income),
                  gapBetween(25),
                  const RadioOfTransactionpage(
                      categoryname: 'Expense', type: CategoryType.expense),
                ],
              ),
              SizedBox(
                height: 20,
              ),

              //  Drop down

              ValueListenableBuilder(
                valueListenable: selectedDropdownValue,
                builder:
                    (BuildContext context, CategoryModel? current, Widget? _) {
                  //  if (selectedradio.value == CategoryType.expense) {
                  //   ;
                  // }

                  return ValueListenableBuilder(
                    valueListenable: selectedradio,
                    builder: (BuildContext context, dynamic radio, Widget? _) {
                      ValueNotifier<List<CategoryModel>> CorrespondingList;

                      if (selectedradio.value == CategoryType.income) {
                        getcategory();

                        CorrespondingList = incomecategorynotifier;
                      } else {
                        getcategory();
                        CorrespondingList = expensecategorynotifier;
                      }

                      return DropdownButton(
                        hint: const Text('Select Item'),
                        value: cccc,
                        items: CorrespondingList.value.map((e) {
                          return DropdownMenuItem(
                            child: Text(e.name ?? ''),
                            value: e,
                            onTap: () {
                              _selectedCategoryItem = e;
                            },
                          );
                        }).toList(),
                        onChanged: (newitem) {
                          cccc = newitem;
                          current = newitem;
                          selectedDropdownValue.value =
                              newitem as CategoryModel;

                          selectedDropdownValue.notifyListeners();
                        },
                      );
                    },
                  );
                },
              ),
              SizedBox(
                height: 30,
              ),

              // SUBMIT BUTTON

              ElevatedButton(
                  onPressed: () {
                    // Funtn od submit button
                    addTransaction(context);
                    getTransaction();
                  
                  },
                  child: const Text('Submit'))
            ],
          ),
        ),
      ),
    );
  }
}

// Radio for income/expense

class RadioOfTransactionpage extends StatelessWidget {
  final String categoryname;
  final CategoryType? type;

  const RadioOfTransactionpage(
      {super.key, required this.categoryname, required this.type});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ValueListenableBuilder(
          valueListenable: selectedradio,
          builder: (BuildContext context, dynamic xxx, Widget? _) {
            return Radio(
                value: type,
                groupValue: xxx,
                onChanged: (newvlaue) {
                  cccc = null;
                  selectedradio.value = newvlaue;
                  selectedradio.notifyListeners();
                });
          },
        ),
        Text(categoryname)
      ],
    );
  }

// following is to add data when Submit button is clicked
}

Future<void> addTransaction(BuildContext context) async {
  final _purpose = ctrlpurpose.text;
  final _amount = ctrlamount.text;
  DateTime? datex = selectdDatevalue.value;
  CategoryType? selectedcategoryType = selectedradio.value;
  selectedradio.notifyListeners();

  if (_purpose.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('   Purpose required'),
        backgroundColor: Color.fromARGB(255, 237, 35, 35),
      ),
    );
  }
  if (_amount.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('   Amount required'),
        backgroundColor: Color.fromARGB(255, 237, 35, 35),
      ),
    );
  }
  if (datex == null) { ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('   Date required'),
        backgroundColor: Color.fromARGB(255, 237, 35, 35),
      ),
    );
    return;
  }
  final _parsedamount = double.tryParse(_amount);
  if (_parsedamount == null) {
    return;
  }
  if (_selectedCategoryItem == null) {
     ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('   Select an Item '),
        backgroundColor: Color.fromARGB(255, 237, 35, 35),
      ),
    );
    return;
  }
  if (selectedcategoryType == null) {
    return;
  } else{
    Navigator.of(context).pop();
  }

  final modelx = TransactionModel(
    Purpose: _purpose,
    Amount: _parsedamount,
    date: datex,
    tranType: selectedcategoryType,
    categotyItem: _selectedCategoryItem!,
  );

  final transBox = await Hive.openBox<TransactionModel>('trans');
  await transBox.add(modelx);
  
}
