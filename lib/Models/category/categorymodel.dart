import 'package:hive_flutter/adapters.dart';
part 'categorymodel.g.dart';
@HiveType(typeId: 0)
enum CategoryType{
  @HiveField(0)
  income,

  @HiveField(1)
  expense,
 
}
@HiveType(typeId: 1)
class CategoryModel {
  @HiveField(1)
  final String? name;

  @HiveField(2)
  final String? id;

  @HiveField(3)
  final CategoryType? catType;

  @HiveField(4)
  final bool? isDeleted;

  
  CategoryModel(
      {required this.name,
      required this.catType,
      this.isDeleted = false,
      required this.id});
}
