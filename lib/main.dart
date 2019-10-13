import 'package:flutter/material.dart';
import 'package:gift_of_the_nile/screens/intro_screen.dart';
import 'package:peek_and_pop/misc.dart' as PeekAndPopMisc;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      key: PeekAndPopMisc.background,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Nile Gift',
        theme: ThemeData(
          fontFamily: 'Righteous',
          primarySwatch: Colors.blue,
        ),
        home: IntroScreen(),
      ),
    );
  }
}
