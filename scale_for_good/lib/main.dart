import 'package:flutter/material.dart';
import 'Pages/HomePage.dart';
import 'Dataflow/LocalStorage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Home Page",
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
      ),
      home: HomePage(title: "Home Page", storage: LocalStorage()),
    );
  }
}