import 'package:flutter/material.dart';
import 'package:gift_of_the_nile/models/charcter.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideosTab extends StatefulWidget {
  final Character _character;

  VideosTab(this._character);

  @override
  _VideosTabState createState() => _VideosTabState();
}

class _VideosTabState extends State<VideosTab> {
  YoutubePlayerController _controller;

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget._character.videos.length,
      physics: ClampingScrollPhysics(),
      itemBuilder: (context, index) {
        if (widget._character.videos != null &&
            widget._character.videos.length > 0) {
          return Padding(
            padding: EdgeInsets.all(10.0),
            child: Container(
              height: 250,
              child: YoutubePlayer(
                context: context,
                videoId: widget._character.videos[index],
                flags: YoutubePlayerFlags(
                  autoPlay: false,
                  showVideoProgressIndicator: true,
                ),
                videoProgressIndicatorColor: Colors.amber,
                progressColors: ProgressColors(
                  playedColor: Colors.amber,
                  handleColor: Colors.amberAccent,
                ),
                onPlayerInitialized: (controller) {
                  _controller = controller;
                },
              ),
            ),
          );
        } else {
          return Center(
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
