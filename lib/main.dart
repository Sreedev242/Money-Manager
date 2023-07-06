import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:personal_money_management_app/Home/Homescreen.dart';
import 'package:personal_money_management_app/Models/category/categorymodel.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Hive.initFlutter();
  if (!Hive.isAdapterRegistered(CategoryModelAdapter().typeId)) {
     Hive.registerAdapter(CategoryModelAdapter());
  }
  if (!Hive.isAdapterRegistered(CategoryTypeAdapter().typeId)) {
      Hive.registerAdapter(CategoryTypeAdapter());
  }
  
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Money Manager',
      theme: ThemeData(
     
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 46, 125, 50)),
        useMaterial3: true,
      ),
      home:Homescreen()
    );
  }
}


  