import 'package:auto_size_text/auto_size_text.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:gift_of_the_nile/index.dart';
import 'package:gift_of_the_nile/presentation/pages/character_profile/character_tabs/ancient_god_about_tab.dart';
import 'package:gift_of_the_nile/presentation/pages/character_profile/character_tabs/gallery_tab.dart';
import 'package:gift_of_the_nile/presentation/pages/character_profile/character_tabs/pharaoh_about_tab.dart';
import 'package:sliver_snap/sliver_snap.dart';

class CharacterProfilePage extends HookWidget {
  const CharacterProfilePage({
    super.key,
    required this.character,
  });

  final CharacterEntity character;

  @override
  Widget build(BuildContext context) {
    final tabController = useTabController(initialLength: 4);
    final currentTabIndex = useState(0);
    const tabStyle = TextStyle(
      fontFamily: 'Righteous',
      fontSize: 18,
    );
    final _loveAnimationName = 'Unlove';
    final int barHeight = 117;

    return Scaffold(
      body: SliverSnap(
        expandedBackgroundColor: Colors.white,
        collapsedBackgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        body: IndexedStack(
          index: currentTabIndex.value,
          children: [
            if (character is PharaohEntity)
              PharaohAboutTab(
                character: character as PharaohEntity,
              )
            else
              AncientGodAboutTab(
                character: character as AncientGodEntity,
              ),
            Container(
              height: 50,
              color: Colors.green,
            ),
            GalleryTab(
              character: character,
            ),
            Container(
              height: 50,
              color: Colors.cyan,
            ),
          ],
          // child: TabBarView(
          //   physics: ClampingScrollPhysics(),
          //   controller: tabController,
          //   children: <Widget>[
          //     Container(),
          //     Container(),
          //     Container(),
          //     Container(),
          //     // aboutTab(_character.characterType),
          //     // MapTab(_character),
          //     // GalleryTab(_character),
          //     // VideosTab(_character),
          //   ],
          // ),
        ),
        collapsedContent: Row(
          children: <Widget>[
            Text(
              character.name ?? '',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            Spacer(),
            Expanded(
              child: Container(
                height: 60,
                child: character.icon == null
                    ? FlareActor(
                        'assets/animation/${character.animationPath}',
                        animation: character.animationName,
                        fit: BoxFit.contain,
                      )
                    : Image.asset(
                        'assets/${character.icon}',
                        fit: BoxFit.contain,
                      ),
              ),
            ),
            IconButton(
              onPressed: () {
                FlutterShare.share(
                  title: '${character.name}',
                  text:
                      'Short Story about ${character.name} (${character.knownFor}) \n${character.story?.substring(0, 100)}...\nTo know more about ${character.name} download Nile Gift now to start the journey with the egyptian history',
                );
              },
              icon: Icon(
                Icons.share,
                color: Colors.black,
              ),
            ),
          ],
        ),
        expandedContent: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Flexible(
              child: Container(
                height: MediaQuery.of(context).size.height / 4,
                child: (character.icon == null)
                    ? FlareActor(
                        'assets/animation/${character.animationPath}',
                        animation: character.animationName,
                        fit: BoxFit.scaleDown,
                      )
                    : Hero(
                        tag: character.name ?? '',
                        child: Image.asset(
                          'assets/${character.icon}',
                        ),
                      ),
              ),
            ),
            Text(
              character.name ?? '',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontFamily: 'Righteous',
                fontSize: 19,
              ),
            ),
            Text(
              character.knownFor ?? '',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.normal,
                fontFamily: 'Righteous',
                fontSize: 17,
              ),
            ),
            if (character.characterType == CharacterType.pharaoh)
              Text(
                '${(character as PharaohEntity).from} - ${(character as PharaohEntity).to}',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.normal,
                  fontFamily: 'Righteous',
                  fontSize: 17,
                ),
              ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    FlutterShare.share(
                      title: '${character.name}',
                      text:
                          'Short Story about ${character.name} (${character.knownFor}) \n${character.story?.substring(0, 100)}...\nTo know more about ${character.name} download Nile Gift now to start the journey with the egyptian history',
                    );
                  },
                  icon: Icon(
                    Icons.share,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () {
                    // _bloc.likeUnlikeCharacter();
                  },
                  child: Container(
                    width: 30,
                    height: 35,
                    child: FlareActor(
                      'assets/animation/reaction_love.flr',
                      animation: true ? 'Love' : 'Unlove',
                      fit: BoxFit.contain,
                      shouldClip: false,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
        expandedContentHeight: MediaQuery.of(context).size.height / 2,
        pinned: true,
        bottom: TabBar(
          unselectedLabelColor: Colors.grey,
          labelColor: Colors.yellow.shade600,
          indicatorColor: Colors.yellow.shade600,
          controller: tabController,
          onTap: (index) => currentTabIndex.value = index,
          tabs: <Widget>[
            Tab(
              child: AutoSizeText(
                'About',
                style: tabStyle,
              ),
            ),
            Tab(
              child: AutoSizeText(
                'Places',
                style: tabStyle,
              ),
            ),
            Tab(
              child: AutoSizeText(
                'Gallery',
                style: tabStyle,
              ),
            ),
            Tab(
              child: AutoSizeText(
                'Videos',
                style: tabStyle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
