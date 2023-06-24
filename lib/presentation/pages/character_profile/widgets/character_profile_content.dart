import 'package:auto_size_text/auto_size_text.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:gift_of_the_nile/index.dart';
import 'package:gift_of_the_nile/presentation/pages/character_profile/character_tabs/ancient_god_about_tab.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sliver_snap/sliver_snap.dart';

class CharacterProfileContent extends HookWidget {
  const CharacterProfileContent({
    super.key,
    required this.character,
  });

  final CharacterEntity character;

  @override
  Widget build(BuildContext context) {
    final tabController = useTabController(initialLength: 4);
    final currentTabIndex = useState(0);
    const tabStyle = TextStyle(
      fontSize: 14,
    );

    return SliverSnap(
      expandedBackgroundColor: Colors.white,
      collapsedBackgroundColor: Colors.white,
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(
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
          // Container(
          //   height: 50,
          //   color: Colors.green,
          // ),
          GalleryTab(
            character: character,
          ),
          VideosTab(
            character,
          )
        ],
      ),
      collapsedContent: Row(
        children: <Widget>[
          Text(
            character.name ?? '',
            style: const TextStyle(
              color: Colors.black,
            ),
          ),
          const Spacer(),
          Expanded(
            child: SizedBox(
              height: 60,
              child: character.icon == null
                  ? FlareActor(
                      'assets/animation/${character.animationPath}',
                      animation: character.animationName,
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
            icon: const Icon(
              Icons.share,
              color: Colors.black,
            ),
          ),
        ],
      ),
      expandedContent: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Flexible(
            child: SizedBox(
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
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 19,
            ),
          ),
          Text(
            character.knownFor ?? '',
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.normal,
              fontSize: 17,
            ),
          ),
          if (character.characterType == CharacterType.pharaoh)
            Text(
              '${(character as PharaohEntity).from} - ${(character as PharaohEntity).to}',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.normal,
                fontSize: 17,
              ),
            ),
          Row(
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
                icon: const Icon(
                  Icons.share,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              ValueListenableBuilder(
                valueListenable: Hive.box<int>(HiveConst.charactersBox).listenable(),
                builder: (context, box, child) {
                  return GestureDetector(
                    onTap: () => context.read<CharacterProfileBloc>().add(
                          CharacterFavoritesTriggered(character),
                        ),
                    child: SizedBox(
                      width: 30,
                      height: 35,
                      child: FlareActor(
                        'assets/animation/reaction_love.flr',
                        animation: box.containsKey(character.id ?? -1)
                            ? 'Love'
                            : 'Unlove',
                        shouldClip: false,
                      ),
                    ),
                  );
                },
              )
            ],
          )
        ],
      ),
      expandedContentHeight: MediaQuery.of(context).size.height / 2,
      bottom: TabBar(
        unselectedLabelColor: Colors.grey,
        labelColor: Colors.yellow.shade600,
        indicatorColor: Colors.yellow.shade600,
        controller: tabController,
        onTap: (index) => currentTabIndex.value = index,
        tabs: const <Widget>[
          Tab(
            child: AutoSizeText(
              'About',
              style: tabStyle,
            ),
          ),
          // Tab(
          //   child: AutoSizeText(
          //     'Places',
          //     style: tabStyle,
          //   ),
          // ),
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
    );
  }
}
