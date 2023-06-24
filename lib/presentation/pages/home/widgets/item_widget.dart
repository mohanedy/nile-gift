import 'package:flutter/material.dart';

class ItemWidget extends StatelessWidget {
  const ItemWidget({
    required this.onPressed,
    required this.itemLabel,
  });

  final void Function() onPressed;
  final String itemLabel;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: () {
        onPressed.call();
      },
      child: Row(
        children: <Widget>[
          Text(
            itemLabel,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontFamily: 'Righteous',
            ),
          ),
          const Spacer(),
          const Icon(
            Icons.arrow_forward_ios,
            color: Colors.white,
          )
        ],
      ),
    );
  }
}
