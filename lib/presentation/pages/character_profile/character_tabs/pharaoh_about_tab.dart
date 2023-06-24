import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:gift_of_the_nile/constants.dart';
import 'package:gift_of_the_nile/domain/entities/index.dart';
import 'package:gift_of_the_nile/presentation/components/show_up_animation.dart';
import 'package:gift_of_the_nile/presentation/utils/extensions/url_launcher_ext.dart';

class PharaohAboutTab extends StatelessWidget {
  const PharaohAboutTab({
    super.key,
    required this.character,
  });

  final PharaohEntity character;

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
            const SizedBox(
              height: 20,
            ),
            const SizedBox(
              height: 20,
            ),
            aboutRow(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () => 'http://www.egypt.travel/'.launchUrl(),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        20,
                      ),
                    ),
                    backgroundColor: Colors.teal,
                  ),
                  child: const Text(
                    'Visit Egypt',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () async => character.knowMore?.launchUrl(),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        20,
                      ),
                    ),
                    backgroundColor: Colors.lightBlue,
                  ),
                  child: const Text(
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
      children: <Widget>[
        ShowUp(
          child: Text(
            'Who Is ${character.name} ?',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ShowUp(
          delay: 700,
          child: Text(
            character.about ?? '',
            style: kGreyTextStyle.copyWith(
              fontSize: 17,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        ShowUp(
          child: Text(
            'Quick Facts About ${character.name}',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ShowUp(
            delay: 700,
            child: ListView.separated(
              padding: const EdgeInsets.all(5),
              shrinkWrap: true,
              itemCount: character.facts?.length ?? 0,
              physics: const ClampingScrollPhysics(),
              itemBuilder: (context, index) {
                return Text(
                  '${index + 1}) ${character.facts![index]}',
                  style: kGreyTextStyle.copyWith(
                    fontSize: 17,
                    fontWeight: FontWeight.normal,
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const Divider();
              },
            ),),
        const SizedBox(
          height: 10,
        ),
        ShowUp(
          child: Text(
            'Stories About ${character.name}',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ShowUp(
          delay: 700,
          child: Text(
            character.story ?? '',
            style: kGreyTextStyle.copyWith(
              fontSize: 17,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
      ],
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
        infoColumn(
          'Dynasty',
          '${character.dynasty}th',
        ),
        infoColumn(
          'Burial',
          character.burial ?? 'NA',
        ),
        infoColumn(
          'Died',
          character.died ?? 'NA',
        ),
        infoColumn(
            'Parents',
            character.parents
                .toString()
                .replaceAll('[', '')
                .replaceAll(']', ''),),
        infoColumn(
            'Consort',
            character.consort
                .toString()
                .replaceAll('[', '')
                .replaceAll(']', ''),),
        infoColumn(
            'Children',
            character.children
                .toString()
                .replaceAll('[', '')
                .replaceAll(']', ''),),
      ],
    );
  }

  Column infoColumn(String label, String val) {
    return Column(
      children: <Widget>[
        ShowUp(
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 17,
              color: Colors.grey,
            ),
          ),
        ),
        ShowUp(
          delay: 500 + 200,
          child: Text(
            val,
            textAlign: TextAlign.center,
            style: const TextStyle(
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

  const TextWithAsset({
    required this.txt,
    required this.asset,
    required this.color,
  });

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
        const SizedBox(
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
