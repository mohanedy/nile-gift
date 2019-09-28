import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gift_of_the_nile/models/ancient_gods.dart';
import 'package:peek_and_pop/Export.dart';
import 'package:peek_and_pop/misc.dart' as PeekAndPopMisc;

class GalleryTab extends StatefulWidget {
  final AncientGodCharacter _character;

  GalleryTab(this._character);

  @override
  _GalleryTabState createState() => _GalleryTabState();
}

class _GalleryTabState extends State<GalleryTab> {
  AncientGodCharacter _character;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _character = widget._character;
  }

  @override
  Widget build(BuildContext context) {
    return StaggeredGridView.countBuilder(
      crossAxisCount: 2,
      padding: EdgeInsets.all(8),
      itemCount: _character.gallery.length,
      itemBuilder: (context, index) {
        return PeekAndPopMisc.scaleDownWrapper(
            PeekAndPopController(
              Material(
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
              true,
              peekAndPopBuilderUseCache: true,
              useHaptics: true,
              treshold: 0.7,
              backdropColor: Colors.white,
              useOverlap: true,
              peekAndPopBuilder: (context, c) {
                return atPeekWrapper(
                  SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: CachedNetworkImage(
                        imageUrl: _character.gallery[index],
                        fit: BoxFit.contain,
                        key: Key("Image"),
                      ),
                    ),
                  ),
                  c,
                );
              },
            ),
            0.5);
      },
      staggeredTileBuilder: (int index) =>
          new StaggeredTile.count(1, index.isEven ? 2 : 1),
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
    );
  }

  Widget atPeekWrapper(
      Widget child, PeekAndPopControllerState _peekAndPopController) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(const Radius.circular(10.0)),
        boxShadow: [
          const BoxShadow(
            color: Colors.black,
            offset: const Offset(0, 15),
            spreadRadius: -5,
            blurRadius: 20,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(const Radius.circular(10.0)),
        child: child,
      ),
    );
  }
}
