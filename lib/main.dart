import 'package:flutter/material.dart';
import 'package:bmr_calculator/constants.dart';
import 'package:bmr_calculator/pages/input_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BMR Calculator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        primaryColor: backgroundColor,
        scaffoldBackgroundColor: backgroundColor,
        appBarTheme: const AppBarTheme(
          backgroundColor: backgroundColor,
          centerTitle: true,
          elevation: 0.0,
        ),
      ),
      // Halaman pertama yang dibuka
      home: const InputPage(),
    );
  }
}
