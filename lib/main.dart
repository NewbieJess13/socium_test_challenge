import 'package:flutter/material.dart';
import 'package:socium_test_challenge/pages/products_list_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Socium Test Challenge',
      theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: const AppBarTheme(backgroundColor: Color(0xFF66347F))),
      home: const ProductListPage(),
    );
  }
}
