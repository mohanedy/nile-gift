import 'package:flutter/material.dart';
import 'package:gift_of_the_nile/index.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Nile Gift',
      theme: ThemeData(
        fontFamily: 'Righteous',
        primarySwatch: Colors.amber,
      ),
      home: HomePage(),
    );
  }
}
