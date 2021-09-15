import 'package:floating_search_bar/floating_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class SliverSearchFloatingBar extends StatelessWidget {
  final String placeHolder;
  final Function(String) onTextChanged;
  final TextEditingController controller;

  SliverSearchFloatingBar(
      {@required this.placeHolder,
      @required this.onTextChanged,
      this.controller});

  @override
  Widget build(BuildContext context) {
    return SliverFloatingBar(
      floating: true,
      elevation: 10.0,
      trailing: RawMaterialButton(
        onPressed: () {
          controller.text = "";
          onTextChanged('');
        },
        constraints: BoxConstraints(
          minHeight: 50,
          minWidth: 50,
        ),
        child: Icon(AntDesign.closecircleo),
      ),
      title: TextField(
        controller: controller,
        onChanged: onTextChanged,
        style: TextStyle(fontSize: 20),
        decoration: InputDecoration(
          hintText: placeHolder,
          hintStyle: TextStyle(fontFamily: 'STC'),
          border: InputBorder.none,
          icon: Icon(
            Feather.search,
            size: 30,
          ),
        ),
      ),
    );
  }
}
