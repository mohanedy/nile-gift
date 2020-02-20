import 'package:auto_size_text/auto_size_text.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:gift_of_the_nile/bloc/character_screen_bloc.dart';
import 'package:gift_of_the_nile/constants.dart';
import 'package:gift_of_the_nile/models/charcter.dart';
import 'package:gift_of_the_nile/models/pharaoh.dart';
import 'package:gift_of_the_nile/screens/character_tabs/about_ancient_god_tab.dart';
import 'package:gift_of_the_nile/screens/character_tabs/about_pharaoh_tab.dart';
import 'package:gift_of_the_nile/screens/character_tabs/gallery_tab.dart';
import 'package:gift_of_the_nile/screens/character_tabs/map_tab.dart';
import 'package:gift_of_the_nile/screens/character_tabs/videos_tab.dart';

class CharacterScreen extends StatefulWidget {
  final Character character;

  CharacterScreen(this.character);

  @override
  _CharacterScreenState createState() => _CharacterScreenState();
}

class _CharacterScreenState extends State<CharacterScreen>
    with SingleTickerProviderStateMixin {
  CharacterScreenBloc _bloc;
  String _loveAnimationName = 'Unlove';
  TabController _tabController;
  final tabStyle = TextStyle(
    fontFamily: 'Righteous',
    fontSize: 18,
  );
  Character _character;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _character = widget.character;
    _bloc = CharacterScreenBloc(_character);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (c, scroll) {
          return [buildSliverAppBar(c)];
        },
        body: TabBarView(
          physics: ClampingScrollPhysics(),
          controller: _tabController,
          children: <Widget>[
            aboutTab(_character.characterType),
            MapTab(_character),
            GalleryTab(_character),
            VideosTab(_character),
          ],
        ),
      ),
    );
  }

  Widget aboutTab(CharacterType type) {
    switch (type) {
      case CharacterType.EgyptianPharaohs:
        return AboutPharaohTab(_character);
      case CharacterType.EgyptianGod:
        return AboutTab(_character);
      default:
        return Container();
    }
  }

  Widget buildSliverAppBar(BuildContext context) {
//    top = constraints.biggest.height;

    return StreamBuilder<double>(
      stream: _bloc.barOffsetStream,
      initialData: MediaQuery.of(context).size.height / 2,
      builder: (context, snapshot) {
        return SliverAppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
          backgroundColor: Colors.white,
          forceElevated: true,
          title: AnimatedOpacity(
              opacity: snapshot.data <= 117 ? 1 : 0,
              duration: Duration(milliseconds: 500),
              child: Row(
                children: <Widget>[
                  Text(
                    _character.name,
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  Spacer(),
                  Expanded(
                    child: Container(
                      height: MediaQuery.of(context).size.height / 2 - 50,
                      child: _character.icon == null
                          ? FlareActor(
                              'resources/animation/${_character.animationPath}',
                              animation: _character.animationName,
                              fit: BoxFit.contain,
                            )
                          : Image.asset(
                              'resources/' + _character.icon,
                              fit: BoxFit.scaleDown,
                            ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Share.text(
                          '${_character.name}',
                          'Short Story about ${_character.name} (${_character.knownFor}) \n${_character.story.substring(0, 100) + '...'}\nTo know more about ${_character.name} download Nile Gift now to start the journey with the egyptian history',
                          'text/plain');
                    },
                    icon: Icon(
                      Icons.share,
                      color: Colors.black,
                    ),
                  ),
                ],
              )),
          pinned: true,
          expandedHeight: MediaQuery.of(context).size.height / 2,
          flexibleSpace: FlexibleSpaceBar(
            title: LayoutBuilder(builder: (context, constraints) {
              _bloc.changeBarOffset(constraints.biggest.height);
              return Container();
            }),
            background: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Flexible(
                  child: Container(
                    height: MediaQuery.of(context).size.height / 4,
                    child: (_character.icon == null)
                        ? FlareActor(
                            'resources/animation/${_character.animationPath}',
                            animation: _character.animationName,
                            fit: BoxFit.scaleDown,
                          )
                        : Hero(
                            tag: _character.name,
                            child: Image.asset('resources/' + _character.icon),
                          ),
                  ),
                ),
                Text(
                  _character.name,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Righteous',
                    fontSize: 19,
                  ),
                ),
                Text(
                  _character.knownFor,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'Righteous',
                    fontSize: 17,
                  ),
                ),
                if (_character.characterType == CharacterType.EgyptianPharaohs)
                  Text(
                    (_character as Pharaoh).from +
                        ' - ' +
                        (_character as Pharaoh).to,
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
                        Share.text(
                            '${_character.name}',
                            'Short Story about ${_character.name} (${_character.knownFor}) \n${_character.story.substring(0, 100) + '...'}\nTo know more about ${_character.name} download Nile Gift now to start the journey with the egyptian history',
                            'text/plain');
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
                        _bloc.likeUnlikeCharacter();
                      },
                      child: StreamBuilder<bool>(
                          stream: _bloc.isLiked,
                          builder: (context, snapshot) {
                            if (snapshot.hasData)
                              return Container(
                                width: 30,
                                height: 35,
                                child: FlareActor(
                                  'resources/animation/reaction_love.flr',
                                  animation: snapshot.data ? 'Love' : 'Unlove',
                                  fit: BoxFit.contain,
                                  shouldClip: false,
                                ),
                              );
                            else
                              return Container();
                          }),
                    )
                  ],
                )
              ],
            ),
            centerTitle: true,
          ),
          bottom: TabBar(
            unselectedLabelColor: Colors.grey,
            labelColor: Colors.yellow.shade600,
            indicatorColor: Colors.yellow.shade600,
            controller: _tabController,
            tabs: <Widget>[
              Tab(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 5.0,
                  ),
                  child: AutoSizeText(
                    'About',
                    style: tabStyle,
                  ),
                ),
              ),
              Tab(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 5.0,
                  ),
                  child: AutoSizeText(
                    'Appeared In',
                    textAlign: TextAlign.center,
                    style: tabStyle.copyWith(
                      fontSize: 12.5,
                    ),
                  ),
                ),
              ),
              Tab(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 5.0,
                  ),
                  child: AutoSizeText(
                    'Gallery',
                    style: tabStyle,
                  ),
                ),
              ),
              Tab(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 5.0,
                  ),
                  child: AutoSizeText(
                    'Videos',
                    style: tabStyle,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
