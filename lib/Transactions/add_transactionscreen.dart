import 'package:flutter/material.dart';
import 'package:personal_money_management_app/Models/category/category_dialogbox.dart';
import 'package:personal_money_management_app/Models/category/categorymodel.dart';
import 'package:personal_money_management_app/Models/category/functions.dart';

//  String? valueOfselectedItem='';
ValueNotifier selectedradio = ValueNotifier(CategoryType.income);
ValueNotifier<DateTime?> selectdDatevalue = ValueNotifier(null);
ValueNotifier<CategoryModel?> selectedDropdownValue = ValueNotifier(null);

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
              ValueListenableBuilder(
                  valueListenable: selectdDatevalue,
                  builder:
                      (BuildContext context, DateTime? chosenDate, Widget? _) {
                    final String date;
                    if (chosenDate == null) {
                      date = 'Select Date';
                    } else {
                      date = chosenDate.toString();
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
                  RadioOfTransactionpage(
                      categoryname: 'Income', type: CategoryType.income),
                  gapBetween(25),
                  RadioOfTransactionpage(
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
                        CorrespondingList = expensecategorynotifier;
                         
                      
                      
                      }

                      return DropdownButton(
                        hint: Text('Select Item'),
                        value: current,
                        items: CorrespondingList.value.map((e) {
                          return DropdownMenuItem(
                            child: Text(e.name ?? ''),
                            value: e,
                          );
                        }).toList(),
                        onChanged: (newitem) {
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
                  },
                  child: Text('Submit'))
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
  final CategoryType type;

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
                  selectedradio.value = newvlaue;
                  selectedradio.notifyListeners();
                });
          },
        ),
        Text(categoryname)
      ],
    );
  }
}
