// import 'package:flutter/material.dart';
// import 'package:personal_money_management_app/Models/category/categorymodel.dart';
// import 'package:intl/intl.dart';
// import '../Models/category/transactionmodel.dart';
// import '../functions.dart';
// import 'package:flutter_slidable/flutter_slidable.dart';

// class TransactionScreen extends StatelessWidget {
//   const TransactionScreen({super.key});


//   @override
//   Widget build(BuildContext context) {
//     getTransaction();
//    getcategory();
//     return Scaffold(
//       backgroundColor: Color.fromARGB(255, 199, 243, 201),
//       body: ValueListenableBuilder(
//         valueListenable:TransactionNotifierlist ,
//         builder: (BuildContext context, List<TransactionModel> TransList, Widget?_) { return
        
//            ListView.separated(
//             itemBuilder: ((context, index) {
//               final Trans=TransList[index];
//               return Slidable(
//                 key: Key(Trans.id!),
//                 startActionPane:ActionPane(
//                   motion: ScrollMotion(), 
//                 children: [
//                   SlidableAction(onPressed:   (ctx){
//                     deleteTransaction(Trans.id);
                 
//                   },
//                   icon:Icons.delete,
//                   backgroundColor: Color.fromARGB(251, 221, 19, 19),)
//                 ]),
//                 child: Card(
//                   child: Padding(
//                     padding:  EdgeInsets.all(8.0),
//                     child: ListTile(
//                       leading:  CircleAvatar(
//                         radius: 50,
//                         backgroundColor: Trans.tranType==CategoryType.income? 
//                         Color.fromARGB(225, 138, 232, 143)
//                         :Color.fromARGB(255, 239, 114, 114),
//                         child: Text(
//                           '${DateFormat.MMMd().format(Trans.date).split(' ').last}\n${DateFormat.MMMd().format(Trans.date).split(' ').first}' 
                          
//                           ),
                
//                         ),
//                       title: Text('Rs ${Trans.Amount}'),
//                       subtitle: Text(Trans.categotyItem.name??''),
//                     ),
//                   ),
//                 ),
//               );
      
//             }),
//             separatorBuilder: ((context, index) {
//               return SizedBox(height: 12,);
//             }),
//             itemCount: TransactionNotifierlist.value.length);
//         },
      
//       )
//     );
//   }

// }
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:personal_money_management_app/Models/category/categorymodel.dart';
import '../Models/category/transactionmodel.dart';
import '../functions.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
   bool nothingOnUi=false;
class TransactionScreen extends StatelessWidget {
  const TransactionScreen({super.key});

  @override
  Widget build(BuildContext context) {
 
    getTransaction();
    getcategory();
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 199, 243, 201),
      body: ValueListenableBuilder(
        valueListenable: TransactionNotifierlist,
        builder: (BuildContext context, List<TransactionModel> TransList, Widget? _) {
        if (TransList.isEmpty) {
         return Center(child: Text('Add Category',style: TextStyle(color: Colors.grey),),);
        }
          return GroupedListView<TransactionModel, DateTime>(
            elements: TransList,
            groupBy: (transaction) => DateTime(transaction.date.year, transaction.date.month, transaction.date.day),
            groupSeparatorBuilder: (DateTime date) => Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                DateFormat.yMMMd().format(date),
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            itemBuilder: (context, transaction) => Slidable(
              key: Key(transaction.id!),
              startActionPane:ActionPane(
                motion: ScrollMotion(), children: [
                SlidableAction(
                  onPressed: (ctx)async{
                 await deleteTransaction(transaction.id);
                //  await getTransaction();
                },
                backgroundColor:Color.fromARGB(255, 237, 50, 50),
                icon: Icons.delete,)
              ]),
              child: Card(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 50,
                      backgroundColor: transaction.tranType ==  CategoryType.income
                          ? Color.fromARGB(225, 138, 232, 143)
                          : Color.fromARGB(255, 239, 114, 114),
                      child: Text(
                        '${DateFormat.MMMd().format(transaction.date).split(' ').last}\n${DateFormat.MMMd().format(transaction.date).split(' ').first}',
                      ),
                    ),
                    title: Text('Rs ${transaction.Amount}'),
                    subtitle: Text(transaction.categotyItem.name ?? ''),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
