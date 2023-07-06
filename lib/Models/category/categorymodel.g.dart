// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'categorymodel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************


@HiveType(typeId: 1)
class CategoryTypeAdapter extends TypeAdapter<CategoryType> {
  @override
  final int typeId = 0;

  @override
  CategoryType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return CategoryType.income;
      case 1:
        return CategoryType.expense;
      case 2:
        return CategoryType.defaultType;
      default:
        return CategoryType.defaultType;
    }
  }

  @override
  void write(BinaryWriter writer, CategoryType obj) {
    switch (obj) {
      case CategoryType.income:
        writer.writeByte(0);
        break;
      case CategoryType.expense:
        writer.writeByte(1);
        break;
      case CategoryType.defaultType:
        writer.writeByte(2);
        break;
    }
  }
}

@HiveType(typeId: 1)
class CategoryModelAdapter extends TypeAdapter<CategoryModel> {
  @override
  final int typeId = 1;
@override
CategoryModel read(BinaryReader reader) {
  final numOfFields = reader.readByte();
  final fields = <int, dynamic>{
    for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
  };
  return CategoryModel(
    name: fields[1] != null ? fields[1] as String : null,
    type: fields[3] != null ? fields[3] as CategoryType : CategoryType.defaultType,
    isDeleted: fields[4] != null ? fields[4] as bool : false,
    id: fields[2] != null ? fields[2] as String : '',
  );
}
  @override
  void write(BinaryWriter writer, CategoryModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.id)
      ..writeByte(3)
      ..write(obj.type)
      ..writeByte(4)
      ..write(obj.isDeleted);
  }
}