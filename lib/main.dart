import 'package:flutter/material.dart';
import 'package:gift_of_the_nile/screens/home_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Nile Gift',
      theme: ThemeData(
        fontFamily: 'Righteous',
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}
