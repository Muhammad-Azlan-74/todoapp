import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:practice/pages/HomePage.dart';

void main() async {
  runApp(const MyApp());

  await Hive.initFlutter();
  //open the box:
  var box = await Hive.openBox('myBox');
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.lightBlue),
      home: Homepage(),
    );
  }
}
