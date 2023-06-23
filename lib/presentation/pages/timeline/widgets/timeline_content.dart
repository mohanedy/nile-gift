import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:gift_of_the_nile/presentation/base/base_bloc_builder.dart';
import 'package:gift_of_the_nile/presentation/pages/character_profile/character_profile_page.dart';
import 'package:gift_of_the_nile/presentation/pages/timeline/bloc/timeline_bloc.dart';
import 'package:timeline_list/timeline.dart';
import 'package:timeline_list/timeline_model.dart';

class TimelineContent extends StatelessWidget {
  const TimelineContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseBlocBuilder<TimelineBloc, TimelineState>(
        onSuccess: (context, state) {
      return AnimationLimiter(
        child: Timeline.builder(
          itemCount: state.characters.length,
          position: TimelinePosition.Left,
          itemBuilder: (context, index) {
            final character = state.characters[index];
            return TimelineModel(
              AnimationConfiguration.staggeredList(
                position: index,
                duration: Duration(seconds: 1),
                child: SlideAnimation(
                  verticalOffset: 50.0,
                  horizontalOffset: 50,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (c) => CharacterProfilePage(
                              character: character,
                            ),
                          ),
                        );
                      },
                      child: Stack(
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                                color: character.characterType.characterColor,
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  new BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 10.0,
                                    offset: new Offset(0.0, 10.0),
                                  ),
                                ]),
                            margin: new EdgeInsets.only(top: 72.0),
                            child: Container(
                              margin:
                                  EdgeInsets.fromLTRB(16.0, 42.0, 16.0, 16.0),
                              child: Column(
                                children: <Widget>[
                                  Container(height: 4.0),
                                  Text(
                                    character.name ?? '',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                  Text(
                                    character.knownFor ?? '',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 17,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                    height: 2,
                                    width: 40,
                                    color: Colors.yellow.shade100,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Wrap(
                                    crossAxisAlignment:
                                        WrapCrossAlignment.center,
                                    alignment: WrapAlignment.center,
                                    runAlignment: WrapAlignment.center,
                                    children: <Widget>[
                                      Icon(
                                        Icons.date_range,
                                        color: Colors.white,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        '${character.date} BC',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Icon(
                                        Icons.clear_all,
                                        color: Colors.white,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        character.characterType.stringName,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Center(
                            child: Hero(
                              tag: character.name ?? '',
                              child: Container(
                                margin: EdgeInsets.symmetric(vertical: 16),
                                width: 200,
                                height: 92,
                                alignment: FractionalOffset.center,
                                child: (character.icon == null ||
                                        character.icon?.isEmpty == true)
                                    ? FlareActor(
                                        'assets/animation/${character.animationPath}',
                                        alignment: Alignment.center,
                                        animation: character.animationName,
                                        fit: BoxFit.cover,
                                      )
                                    : Image.asset(
                                        'assets/${character.icon}',
                                      ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              position: TimelineItemPosition.random,
              iconBackground: character.characterType.characterColor,
            );
          },
          lineColor: Colors.grey,
        ),
      );
    });
  }
}
