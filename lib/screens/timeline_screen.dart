import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:timeline_list/timeline.dart';
import 'package:timeline_list/timeline_model.dart';

class TimelineScreen extends StatefulWidget {
  @override
  _TimelineScreenState createState() => _TimelineScreenState();
}

//#FFCF40
class _TimelineScreenState extends State<TimelineScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Egyptian Timeline',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Timeline.builder(
        itemCount: 10,
        position: TimelinePosition.Left,
        itemBuilder: (context, index) {
          return TimelineModel(
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Stack(
                children: <Widget>[
                  Container(
                    height: 154,
                    decoration: BoxDecoration(
                        color: Colors.yellow.shade800,
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
                      margin: EdgeInsets.fromLTRB(16.0, 42.0, 16.0, 16.0),
                      child: Column(
                        children: <Widget>[
                          Container(height: 4.0),
                          Text(
                            'RA',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                'The God of The Sun',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              ImageIcon(
                                AssetImage(
                                  'resources/images/sunny.png',
                                ),
                                color: Colors.white70,
                              )
                            ],
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.date_range,
                                color: Colors.yellow.shade100,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                '3000 BC',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                              Spacer(),
                              Icon(
                                Icons.clear_all,
                                color: Colors.yellow.shade100,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                'Ancient God',
                                style: TextStyle(
                                  color: Colors.white70,
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
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 16),
                      width: 200,
                      height: 92,
                      alignment: FractionalOffset.center,
                      child: FlareActor(
                        'resources/animation/Ra.flr',
                        alignment: Alignment.center,
                        animation: 'Ra Animation',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            position: TimelineItemPosition.random,
            iconBackground: Colors.yellow.shade800,
          );
        },
        lineColor: Colors.grey,
      ),
    );
  }
}
