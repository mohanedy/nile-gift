import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gift_of_the_nile/component/loading_progress.dart';
import 'package:gift_of_the_nile/models/charcter_entity.dart';

class GalleryTab extends StatefulWidget {
  final Character _character;

  GalleryTab(this._character);

  @override
  _GalleryTabState createState() => _GalleryTabState();
}

class _GalleryTabState extends State<GalleryTab> {
  Character _character;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _character = widget._character;
  }

  @override
  Widget build(BuildContext context) {
    return AnimationLimiter(
      child: StaggeredGridView.countBuilder(
        crossAxisCount: 2,
        padding: EdgeInsets.all(8),
        itemCount: _character.gallery.length,
        itemBuilder: (context, index) {
          return AnimationConfiguration.staggeredGrid(
            position: index,
            duration: const Duration(milliseconds: 375),
            columnCount: 2,
            child: ScaleAnimation(
              child: FadeInAnimation(
                child: Material(
                  elevation: 8,
                  color: Colors.white,
                  clipBehavior: Clip.antiAlias,
                  borderRadius: BorderRadius.circular(20),
                  child: CachedNetworkImage(
                    imageUrl: _character.gallery[index],
                    placeholder: (context, val) {
                      return Center(child: LoadingProgress());
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
              ),
            ),
          );
        },
        staggeredTileBuilder: (int index) =>
            new StaggeredTile.count(1, index.isEven ? 2 : 1),
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),
    );
  }
}
