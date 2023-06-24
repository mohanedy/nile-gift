import 'package:flutter/material.dart';
import 'package:gift_of_the_nile/domain/entities/character_entity.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideosTab extends StatefulWidget {

  const VideosTab(this.character);

  final CharacterEntity character;

  @override
  _VideosTabState createState() => _VideosTabState();
}

class _VideosTabState extends State<VideosTab> {
  final List<YoutubePlayerController> _controllers = [];

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.character.videos?.length ?? 0,
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemBuilder: (context, index) {
        final controller = YoutubePlayerController(
          initialVideoId: widget.character.videos![index],
          flags: const YoutubePlayerFlags(
            autoPlay: false,
          ),
        );
        _controllers.add(controller);
        if (widget.character.videos != null &&
            widget.character.videos!.isNotEmpty == true) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: SizedBox(
              height: 250,
              child: YoutubePlayer(
                controller: controller,
                liveUIColor: Colors.amber,
                progressIndicatorColor: Colors.amber,
                showVideoProgressIndicator: true,
              ),
            ),
          );
        } else {
          return const Center(
            child: Text(
              'No Videos Available',
              style: TextStyle(
                fontSize: 22,
                color: Colors.amber,
              ),
            ),
          );
        }
      },
    );
  }
}
