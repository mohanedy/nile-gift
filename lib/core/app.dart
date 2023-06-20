import 'package:flutter/material.dart';

class App extends StatelessWidget {
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