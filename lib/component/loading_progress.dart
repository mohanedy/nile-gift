import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

class LoadingProgress extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      height: 150,
      child: FlareActor(
        'resources/animation/cat.flr',
        animation: 'animation',
      ),
    );
  }
}
