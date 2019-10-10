import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:gift_of_the_nile/bloc/timeline_bloc.dart';
import 'package:gift_of_the_nile/constants.dart';
import 'package:gift_of_the_nile/models/charcter.dart';
import 'package:gift_of_the_nile/screens/character_screen.dart';
import 'package:timeline_list/timeline.dart';
import 'package:timeline_list/timeline_model.dart';

class TimelineScreen extends StatefulWidget {
  @override
  _TimelineScreenState createState() => _TimelineScreenState();
}

//#FFCF40
class _TimelineScreenState extends State<TimelineScreen> {
  TimelineBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = TimelineBloc(context);
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Timeline',
          style: TextStyle(
            color: Colors.amber,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.amber,
          ),
        ),
      ),
      body: StreamBuilder<List<Character>>(
          stream: _bloc.characters,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return AnimationLimiter(
                child: Timeline.builder(
                  itemCount: snapshot.data.length,
                  position: TimelinePosition.Left,
                  itemBuilder: (context, index) {
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
                                        builder: (c) => CharacterScreen(
                                              snapshot.data[index],
                                            )));
                              },
                              child: Stack(
                                children: <Widget>[
                                  Container(
                                    decoration: BoxDecoration(
                                        color: characterColor(
                                            snapshot.data[index].characterType),
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
                                      margin: EdgeInsets.fromLTRB(
                                          16.0, 42.0, 16.0, 16.0),
                                      child: Column(
                                        children: <Widget>[
                                          Container(height: 4.0),
                                          Text(
                                            snapshot.data[index].name,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                            ),
                                          ),
                                          Text(
                                            snapshot.data[index].knownFor,
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
                                                snapshot.data[index].date
                                                        .toString() +
                                                    ' BC',
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
                                                characterType(snapshot
                                                    .data[index].characterType),
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
                                      tag: snapshot.data[index].name,
                                      child: Container(
                                        margin:
                                            EdgeInsets.symmetric(vertical: 16),
                                        width: 200,
                                        height: 92,
                                        alignment: FractionalOffset.center,
                                        child: (snapshot.data[index].icon ==
                                                    null ||
                                                snapshot
                                                    .data[index].icon.isEmpty)
                                            ? FlareActor(
                                                'resources/animation/' +
                                                    snapshot.data[index]
                                                        .animationPath,
                                                alignment: Alignment.center,
                                                animation: snapshot
                                                    .data[index].animationName,
                                                fit: BoxFit.cover,
                                              )
                                            : Image.asset('resources/' +
                                                snapshot.data[index].icon),
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
                      iconBackground:
                          characterColor(snapshot.data[index].characterType),
                    );
                  },
                  lineColor: Colors.grey,
                ),
              );
            } else {
              return CircularProgressIndicator();
            }
          }),
    );
  }

  Color characterColor(CharacterType characterType) {
    switch (characterType) {
      case CharacterType.EgyptianPharaohs:
        return Colors.yellow.shade800;
      case CharacterType.EgyptianGod:
        return Colors.lightBlue.shade700;
      case CharacterType.EgyptianKing:
        return Colors.red;
      case CharacterType.EgyptianPresident:
        return Colors.teal;
      default:
        return Colors.lightBlue;
    }
  }

  String characterType(CharacterType characterType) {
    switch (characterType) {
      case CharacterType.EgyptianPharaohs:
        return 'Pharaoh';
      case CharacterType.EgyptianGod:
        return 'Ancient God';
      case CharacterType.EgyptianKing:
        return 'King';
      case CharacterType.EgyptianPresident:
        return 'President';
      default:
        return '';
    }
  }
}
