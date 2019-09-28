import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gift_of_the_nile/models/ancient_gods.dart';

class GalleryTab extends StatelessWidget {
  final AncientGodCharacter _character;

  GalleryTab(this._character);

  @override
  Widget build(BuildContext context) {
    return StaggeredGridView.countBuilder(
      crossAxisCount: 2,
      padding: EdgeInsets.all(8),
      itemCount: _character.gallery.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onLongPress: () {
            print('long press');
          },
          onForcePressPeak: (v) {
            print(v);
          },
          onLongPressEnd: (e) {
            print(e.globalPosition);
          },
          child: Material(
            elevation: 8,
            color: Colors.white,
            clipBehavior: Clip.antiAlias,
            borderRadius: BorderRadius.circular(20),
            child: CachedNetworkImage(
              imageUrl: _character.gallery[index],
              placeholder: (context, val) {
                return Center(child: CircularProgressIndicator());
              },
              fadeInCurve: Curves.bounceIn,
              fadeOutCurve: Curves.bounceIn,
              fit: BoxFit.cover,
              errorWidget: (context, status, o) {
                return Icon(
                  Icons.error,
                );
              },
            ),
          ),
        );
      },
      staggeredTileBuilder: (int index) =>
          new StaggeredTile.count(1, index.isEven ? 2 : 1),
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
    );
  }
}
