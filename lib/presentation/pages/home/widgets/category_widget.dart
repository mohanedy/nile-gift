import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

class CategoryWidget extends StatelessWidget {
  final GlobalKey? key2;
  final String flareImage;
  final String animationName;
  final String label;
  final List<Widget> items;
  final Color color;
  final Function(bool)? onExpand;

  const CategoryWidget(
    this.items, {
    required this.flareImage,
     this.key2,
    required this.animationName,
    required this.label,
    required this.color,
     this.onExpand,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      key: key2,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 10,
      color: color,
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/images/heroBackground.jpg',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: ExpansionTile(
          onExpansionChanged: onExpand,
          trailing: const Icon(
            Icons.add,
            color: Colors.white,
          ),
          backgroundColor: color,
          title: SizedBox(
            height: 120,
            child: Row(
              children: <Widget>[
                Flexible(
                  child: SizedBox(
                    height: 130,
                    child: FlareActor(
                      flareImage,
                      animation: animationName,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: Text(
                    label,
                    style: const TextStyle(
                      fontSize: 27,
                      fontWeight: FontWeight.normal,
                      color: Colors.white,
                      fontFamily: 'Righteous',
                    ),
                  ),
                ),
              ],
            ),
          ),
          children: items,
        ),
      ),
    );
  }
}
