import 'package:flutter/material.dart';
import 'screens/main_menu.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JUAN-CON',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        fontFamily: 'Segoe UI',
        scaffoldBackgroundColor: Colors.black,
      ),
      home: MainMenuScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}