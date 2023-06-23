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

  CategoryWidget(
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
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/images/heroBackground.jpg',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: ExpansionTile(
          onExpansionChanged: onExpand,
          trailing: Icon(
            Icons.add,
            color: Colors.white,
          ),
          backgroundColor: color,
          title: Container(
            height: 120,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Flexible(
                  flex: 1,
                  child: Container(
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
                    style: TextStyle(
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
