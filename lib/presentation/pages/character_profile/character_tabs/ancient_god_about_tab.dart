import 'package:auto_size_text/auto_size_text.dart';
import 'package:circle_list/circle_list.dart';
import 'package:flutter/material.dart';
import 'package:gift_of_the_nile/constants.dart';
import 'package:gift_of_the_nile/domain/entities/ancient_gods/ancient_god_entity.dart';
import 'package:gift_of_the_nile/presentation/components/show_up_animation.dart';
import 'package:gift_of_the_nile/presentation/utils/extensions/safe_string_ext.dart';
import 'package:url_launcher/url_launcher_string.dart';

class AncientGodAboutTab extends StatelessWidget {
  const AncientGodAboutTab({required this.character});

  final AncientGodEntity character;

  @override
  Widget build(BuildContext context) {
    const delay = 500;
    const contentDelay = 700;

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
                ElevatedButton(
                  onPressed: () async {
                    if (await canLaunchUrlString('http://www.egypt.travel/')) {
                      await launchUrlString('http://www.egypt.travel/');
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        20,
                      ),
                    ),
                    backgroundColor: Colors.teal,
                  ),
                  child: Text(
                    'Visit Egypt',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (await canLaunchUrlString(character.knowMore ?? '')) {
                      await launchUrlString(character.knowMore ?? '');
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        20,
                      ),
                    ),
                    backgroundColor: Colors.lightBlue,
                  ),
                  child: Text(
                    'Know More',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
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
        ShowUp(
          delay: 500,
          child: Text(
            'Who Is ${character.name} ?',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ShowUp(
          delay: 700,
          child: Text(
            character.about.safeStr,
            style: kGreyTextStyle.copyWith(
              fontSize: 17,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        ShowUp(
          child: Text(
            'Stories About ${character.name}',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ShowUp(
          delay: 700,
          child: Text(
            character.story.safeStr,
            style: kGreyTextStyle.copyWith(
              fontSize: 17,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
      ],
    );
  }

  Widget buildGodList() {
    return Center(
      child: CircleList(
        innerCircleRotateWithChildren: true,
        onDragStart: (c) {
          print(c);
        },
        outerRadius: 130,
        origin: Offset(0, 0),
        showInitialAnimation: true,
        children: character.godOf?.map((v) {
              return TextWithAsset(
                txt: v.value,
                asset: 'assets/${v.asset}',
                color: Colors.white,
              );
            })?.toList() ??
            [],
        outerCircleColor: Colors.lightBlue,
        innerRadius: 36,
        isChildrenVertical: true,
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

//  Widget buildBelievedInList() {
//    return Center(
//      child: CircleList(
//        outerCircleRotateWithChildren: true,
//        innerCircleRotateWithChildren: true,
//        onDragStart: (c) {
//          print(c);
//        },
//        outerRadius: 130,
//        origin: Offset(0, 0),
//        showInitialAnimation: true,
//        children: _character.believedIn.map((v) {
//          return Text(
//            v,
//            style: TextStyle(
//              fontSize: 18,
//              color: Colors.white,
//            ),
//          );
//        }).toList(),
//        outerCircleColor: Colors.lightBlue,
//        innerRadius: 50,
//        onDragUpdate: (v) {
//          print(v.angle);
//        },
//        centerWidget: Text(
//          'Kings Believed In',
//          textAlign: TextAlign.center,
//          style: TextStyle(
//            fontWeight: FontWeight.normal,
//            fontSize: 18,
//            color: Colors.grey,
//          ),
//        ),
//      ),
//    );
//  }

  Widget topRow() {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      alignment: WrapAlignment.spaceEvenly,
      runAlignment: WrapAlignment.spaceEvenly,
      spacing: 20,
      runSpacing: 10,
      children: <Widget>[
        infoColumn('When', character.since ?? ''),
        infoColumn('Symbol', character.symbol ?? ''),
        infoColumn(
            'Parents',
            character.parents
                .toString()
                .replaceAll('[', '')
                .replaceAll(']', '')),
        infoColumn(
            'Consort',
            character.consort
                .toString()
                .replaceAll('[', '')
                .replaceAll(']', '')),
        infoColumn(
            'Siblings',
            character.siblings
                .toString()
                .replaceAll('[', '')
                .replaceAll(']', '')),
      ],
    );
  }

  Column infoColumn(String label, String val) {
    return Column(
      children: <Widget>[
        ShowUp(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 17,
              color: Colors.grey,
            ),
          ),
          delay: 500,
        ),
        ShowUp(
          delay: 500 + 200,
          child: Text(
            val,
            style: TextStyle(
              fontSize: 17,
            ),
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

  TextWithAsset({required this.txt, required this.asset, required this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Flexible(
          child: AutoSizeText(
            txt,
            textAlign: TextAlign.center,
            maxLines: 1,
            style: TextStyle(
              fontSize: 15,
              color: color,
            ),
          ),
        ),
        SizedBox(
          width: 0,
        ),
        Image.asset(
          asset,
          width: 25,
          height: 25,
        )
      ],
    );
  }
}
