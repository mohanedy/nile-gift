import 'package:flutter/material.dart';

class ItemWidget extends StatelessWidget {
  const ItemWidget({
    required this.onPressed,
    required this.itemLabel,
  });

  final Function onPressed;
  final String itemLabel;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: () {
        onPressed();
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            itemLabel,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontFamily: 'Righteous',
            ),
          ),
          Spacer(),
          Icon(
            Icons.arrow_forward_ios,
            color: Colors.white,
          )
        ],
      ),
    );
  }
}
