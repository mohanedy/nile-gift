import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gift_of_the_nile/domain/entities/character_entity.dart';
import 'package:gift_of_the_nile/presentation/components/loading_progress.dart';

class GalleryTab extends StatelessWidget {
  const GalleryTab({
    super.key,
    required this.character,
  });

  final CharacterEntity character;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: AnimationLimiter(
        child: StaggeredGrid.count(
          crossAxisCount: 2,
          children: character.gallery
                  ?.map((img) => AnimationConfiguration.staggeredGrid(
                        position: character.gallery!.indexOf(img),
                        delay: const Duration(milliseconds: 375),
                        duration: const Duration(milliseconds: 500),
                        columnCount: 2,
                        child: ScaleAnimation(
                          child: FadeInAnimation(
                            child: Material(
                              elevation: 8,
                              color: Colors.white,
                              clipBehavior: Clip.antiAlias,
                              borderRadius: BorderRadius.circular(20),
                              child: CachedNetworkImage(
                                imageUrl: img,
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
                      ))
                  ?.toList() ??
              [],
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
        ),
      ),
    );
  }
}
