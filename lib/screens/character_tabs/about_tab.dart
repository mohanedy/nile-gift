import 'package:circle_list/circle_list.dart';
import 'package:flutter/material.dart';
import 'package:gift_of_the_nile/constants.dart';

class AboutTab extends StatefulWidget {
  @override
  _AboutTabState createState() => _AboutTabState();
}

class _AboutTabState extends State<AboutTab> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            topRow(),
            SizedBox(
              height: 20,
            ),
            buildGodList(),
            SizedBox(
              height: 20,
            ),
            aboutRow(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RaisedButton(
                  onPressed: () {},
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      20,
                    ),
                  ),
                  child: Text(
                    'Visit Egypt',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  color: Colors.teal,
                ),
                RaisedButton(
                  onPressed: () {},
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      20,
                    ),
                  ),
                  child: Text(
                    'Know More',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  color: Colors.lightBlue,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget aboutRow() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Text(
          'Who Is Ra ?',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          ' is the ancient Egyptian deity of the sun. By the Fifth Dynasty in the 25th and 24th centuries BC, he had become one of the most important gods in ancient Egyptian religion, identified primarily with the noon sun. Ra was believed to rule in all parts of the created world: the sky, the Earth, and the underworld. He was the god of the sun, order, kings, and the sky',
          style: kGreyTextStyle.copyWith(
            fontSize: 17,
            fontWeight: FontWeight.normal,
          ),
        ),
        buildBelievedInList(),
        SizedBox(
          height: 10,
        ),
        Text(
          'Stories About Ra',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          'Ra wanted to teach the people he made how to live. So he took on the shape of a man and became the first pharaoh, king of Egypt. Since Ra was now in the form of a man, he could no longer stay young forever. He was bound to grow old one day. After ruling Egypt for many thousands of years, that time finally came. At his old age, Ra began to notice that his people no longer respected him. They laughed at him. They mocked him. They said, "Look at Ra! Ra is so old! His bones are like silver, his flesh like gold, and his hair the color of lapis lazuli!" They also said, We cant go on like this. We need a new leader.',
          style: kGreyTextStyle.copyWith(
            fontSize: 17,
            fontWeight: FontWeight.normal,
          ),
        ),
      ],
    );
  }

  Widget buildGodList() {
    return Center(
      child: CircleList(
        outerCircleRotateWithChildren: true,
        innerCircleRotateWithChildren: true,
        onDragStart: (c) {
          print(c);
        },
        outerRadius: 130,
        origin: Offset(0, 0),
        showInitialAnimation: true,
        children: <Widget>[
          TextWithAsset(
            txt: 'Sun',
            asset: 'resources/images/sunny.png',
            color: Colors.white,
          ),
          TextWithAsset(
            txt: 'Sky',
            asset: 'resources/images/cloudy.png',
            color: Colors.white,
          ),
          Container(),
          TextWithAsset(
            txt: 'Underworld',
            asset: 'resources/images/moon.png',
            color: Colors.white,
          ),
        ],
        outerCircleColor: Colors.lightBlue,
        innerRadius: 50,
        onDragUpdate: (v) {
          print(v.angle);
        },
        centerWidget: Text(
          'God of',
          style: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 18,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }

  Widget buildBelievedInList() {
    return Center(
      child: CircleList(
        outerCircleRotateWithChildren: true,
        innerCircleRotateWithChildren: true,
        onDragStart: (c) {
          print(c);
        },
        outerRadius: 130,
        origin: Offset(0, 0),
        showInitialAnimation: true,
        children: <Widget>[
          
          Text(
            'Menkauhor Kaiu',
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
            ),
          ),
          Text(
            'Sahure',
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
            ),
          ),
          Text(
            'Neferirkare Kakai',
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
            ),
          ),
        ],
        outerCircleColor: Colors.lightBlue.shade700,
        innerRadius: 50,
        onDragUpdate: (v) {
          print(v.angle);
        },
        centerWidget: Text(
          'Kings Believed In',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 18,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }

  Widget topRow() {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      alignment: WrapAlignment.spaceEvenly,
      runAlignment: WrapAlignment.spaceEvenly,
      spacing: 20,
      runSpacing: 10,
      children: <Widget>[
        infoColumn('When', '2494 BC'),
        infoColumn('Symbol', 'Noon Sun - Falcon'),
        infoColumn('Parents', 'None'),
        infoColumn('Consort', 'Hathor, Sekhmet, Bastet'),
        infoColumn('Siblings', 'Apep, Sobek, Serket'),
      ],
    );
  }

  Column infoColumn(String label, String val) {
    return Column(
      children: <Widget>[
        Text(
          label,
          style: TextStyle(
            fontSize: 17,
            color: Colors.grey,
          ),
        ),
        Text(
          val,
          style: TextStyle(
            fontSize: 17,
          ),
        )
      ],
    );
  }
}

class TextWithAsset extends StatelessWidget {
  final String txt;
  final String asset;
  final Color color;

  TextWithAsset({this.txt, this.asset, this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          txt,
          style: TextStyle(
            fontSize: 18,
            color: color,
          ),
        ),
        SizedBox(
          width: 3,
        ),
        Image.asset(
          asset,
          width: 30,
          height: 30,
        )
      ],
    );
  }
}
