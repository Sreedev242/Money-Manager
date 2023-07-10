import 'package:hive_flutter/adapters.dart';
import 'package:personal_money_management_app/Models/category/categorymodel.dart';
part 'transactionmodel.g.dart';

 @HiveType(typeId: 2)
class TransactionModel {

  @HiveField(0)
  final String Purpose;
  @HiveField(1)
  final double Amount;
  @HiveField(2)
  final DateTime date;
  @HiveField(3)
  final CategoryType? tranType;
  @HiveField(4)
  final CategoryModel categotyItem;
  @HiveField(5)
   String? id;

  TransactionModel({
    required this.Purpose,
    required this.Amount,
    required this.date,
    required this.tranType,
    required this.categotyItem,
    this.id
  }){
    id=DateTime.now().millisecondsSinceEpoch.toString();
  }
}
