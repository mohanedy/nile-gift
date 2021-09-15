import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:gift_of_the_nile/bloc/home_screen_bloc.dart';
import 'package:gift_of_the_nile/component/loading_progress.dart';
import 'package:gift_of_the_nile/component/sliver_floating_search.dart';
import 'package:gift_of_the_nile/models/ancient_gods.dart';
import 'package:gift_of_the_nile/models/charcter.dart';
import 'package:gift_of_the_nile/models/pharaoh.dart';
import 'package:gift_of_the_nile/screens/about_screen.dart';
import 'package:gift_of_the_nile/screens/character_screen.dart';
import 'package:gift_of_the_nile/screens/fav_characters.dart';
import 'package:gift_of_the_nile/screens/timeline_screen.dart';
import 'package:koukicons/info.dart';
import 'package:koukicons/likeX.dart';
import 'package:koukicons/share.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeScreenBloc _bloc;
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _bloc = HomeScreenBloc(context);
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: StreamBuilder<bool>(
            stream: _bloc.isLoading,
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data == false) {
                return StreamBuilder<bool>(
                    stream: _bloc.isSearching,
                    initialData: false,
                    builder: (context, searchingSnapshot) {
                      return CustomScrollView(
                        slivers: <Widget>[
                          SliverList(
                            delegate: SliverChildListDelegate([
                              Column(
                                children: <Widget>[
                                  Stack(
                                    children: <Widget>[
                                      Positioned(
                                        top: 20,
                                        left: 10,
                                        child: IconButton(
                                          icon: Icon(
                                            Icons.timeline,
                                            size: 40,
                                          ),
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (c) =>
                                                        TimelineScreen()));
                                          },
                                          color: Colors.yellow.shade700,
                                          tooltip: 'Egyptian Timeline',
                                        ),
                                      ),
                                      Center(
                                        child: Container(
                                          height: 140,
                                          child: Image.asset(
                                              'resources/images/pyramids.png'),
                                        ),
                                      ),
//                                      Positioned(
//                                        top: 20,
//                                        right: 10,
//                                        child: IconButton(
//                                          icon: KoukiconsNotebook1(),
//                                          onPressed: () {
//                                            Navigator.push(
//                                                context,
//                                                MaterialPageRoute(
//                                                    builder: (c) =>
//                                                        BooksHomeScreen()));
//                                          },
//                                          tooltip: 'Library',
//                                        ),
//                                      ),
                                    ],
                                  ),
                                  Text(
                                    'Gift of The Nile',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25,
                                      color: Colors.black,
                                      fontFamily: 'Righteous',
                                    ),
                                  ),
                                  Text(
                                    'Where it all begins',
                                    style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 18,
                                      color: Colors.grey,
                                      fontFamily: 'Righteous',
                                    ),
                                  ),
                                ],
                              ),
                            ]),
                          ),
                          SliverPadding(
                            padding: EdgeInsets.only(top: 20),
                            sliver: StreamBuilder<String>(
                                stream: _bloc.searchText,
                                builder: (context, searchQuery) {
                                  return SliverSearchFloatingBar(
                                    placeHolder: 'Search here',
                                    onTextChanged: (txt) {
                                      if (txt != null && txt.isNotEmpty) {
                                        _bloc.onSearchingChange(true);
                                        _bloc.onSearchChange(txt);
                                      } else {
                                        _bloc.onSearchingChange(false);
                                      }
                                    },
                                    controller: _controller,
                                  );
                                }),
                          ),
                          SliverList(
                            delegate: SliverChildListDelegate(searchingSnapshot
                                    .data
                                ? [
                                    StreamBuilder<List<Character>>(
                                        stream: _bloc.searchResult,
                                        builder: (context, result) {
                                          if (result.hasData &&
                                              result.data.length > 0) {
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: ListView.separated(
                                                shrinkWrap: true,
                                                physics:
                                                    ClampingScrollPhysics(),
                                                itemBuilder: (context, index) {
                                                  return CharacterListWidget(
                                                    character:
                                                        result.data[index],
                                                  );
                                                },
                                                separatorBuilder:
                                                    (context, index) {
                                                  return Divider();
                                                },
                                                itemCount: result.data.length,
                                              ),
                                            );
                                          } else if (result.hasData &&
                                              (result.data == null ||
                                                  result.data.length == 0)) {
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: Center(
                                                child: Text(
                                                  'No Matching',
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                  ),
                                                ),
                                              ),
                                            );
                                          } else {
                                            return Center(
                                                child: Container(
                                                    width: 100,
                                                    height: 100,
                                                    child: LoadingProgress()));
                                          }
                                        }),
                                  ]
                                : [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: StreamBuilder<AncientGods>(
                                          stream: _bloc.ancientGods,
                                          builder: (context, ancientGods) {
                                            if (ancientGods.hasData)
                                              return CategoryWidget(
                                                ancientGods.data.characters
                                                    .map((v) {
                                                  return Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: 20.0,
                                                      right: 20,
                                                    ),
                                                    child: ItemWidget(
                                                      itemLabel: v.name,
                                                      onPressed: () {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (c) =>
                                                                    CharacterScreen(
                                                                      v,
                                                                    )));
                                                      },
                                                    ),
                                                  );
                                                }).toList(),
                                                animationName: 'Ra Animation',
                                                flareImage:
                                                    'resources/animation/Ra.flr',
                                                label: 'Egyptian Gods',
                                                color: Colors.transparent,
                                              );
                                            else
                                              return Container();
                                          }),
                                    ),
                                    StreamBuilder<Pharaohs>(
                                        stream: _bloc.pharaohs,
                                        builder: (context, pharaohs) {
                                          if (pharaohs.hasData) {
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: CategoryWidget(
                                                pharaohs.data.characters
                                                    .map((v) {
                                                  return Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: 20.0,
                                                      right: 20,
                                                    ),
                                                    child: ItemWidget(
                                                      itemLabel: v.name,
                                                      onPressed: () {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (c) =>
                                                                    CharacterScreen(
                                                                      v,
                                                                    )));
                                                      },
                                                    ),
                                                  );
                                                }).toList(),
                                                animationName: 'eye',
                                                flareImage:
                                                    'resources/animation/pharoh.flr',
                                                label: 'Egyptian Pharaohs',
                                                color: Colors.transparent,
                                              ),
                                            );
                                          } else {
                                            return Container();
                                          }
                                        }),
                                    Divider(
                                      height: 50,
                                      thickness: 3,
                                      endIndent: 20,
                                      indent: 20,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.0),
                                      child: RawMaterialButton(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            KoukiconsLikeX(
                                              width: 30,
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              'Your Favorites',
                                              style: TextStyle(
                                                fontSize: 18,
                                              ),
                                            ),
                                          ],
                                        ),
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (c) =>
                                                      FavoritesCharacters()));
                                        },
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.0),
                                      child: RawMaterialButton(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            KoukiconsShare(
                                              width: 30,
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              'Share',
                                              style: TextStyle(
                                                fontSize: 18,
                                              ),
                                            ),
                                          ],
                                        ),
                                        onPressed: () {
                                          FlutterShare.share(
                                            title: 'Nile Gift',
                                            text:
                                                'Download Nile Gift now to start the journey with the egyptian history',
                                            chooserTitle: 'Nile Gift',
                                          );
                                          // title: 'Nile Gift',
                                          //
                                          // 'Download Nile Gift now to start the journey with the egyptian history',
                                          // 'text/plain',
                                        },
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.0),
                                      child: RawMaterialButton(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            KoukiconsInfo(
                                              width: 30,
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              'About',
                                              style: TextStyle(
                                                fontSize: 18,
                                              ),
                                            ),
                                          ],
                                        ),
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (c) =>
                                                      AboutScreen()));
                                        },
                                      ),
                                    ),
                                  ]),
                          ),
                        ],
                      );
                    });
              } else {
                return Center(child: LoadingProgress());
              }
            }),
      ),
    );
  }
}

class CategoryWidget extends StatelessWidget {
  final GlobalKey key2;
  final String flareImage;
  final String animationName;
  final String label;
  final List<Widget> items;
  final Color color;
  final Function(bool) onExpand;

  CategoryWidget(this.items,
      {this.flareImage,
      this.key2,
      this.animationName,
      this.label,
      this.color,
      this.onExpand});

  @override
  Widget build(BuildContext context) {
    return Material(
      key: key2,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 10,
      color: color,
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'resources/images/heroBackground.jpg',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: ExpansionTile(
          onExpansionChanged: onExpand,
          trailing: Icon(
            Icons.add,
            color: Colors.white,
          ),
          backgroundColor: color,
          title: Container(
            height: 120,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Flexible(
                  flex: 1,
                  child: Container(
                    height: 130,
                    child: FlareActor(
                      flareImage,
                      animation: animationName,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: Text(
                    label,
                    style: TextStyle(
                      fontSize: 27,
                      fontWeight: FontWeight.normal,
                      color: Colors.white,
                      fontFamily: 'Righteous',
                    ),
                  ),
                ),
              ],
            ),
          ),
          children: items,
        ),
      ),
    );
  }
}

class ItemWidget extends StatelessWidget {
  final Function onPressed;
  final String itemLabel;

  ItemWidget({this.onPressed, this.itemLabel});

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: () {
        onPressed();
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            itemLabel,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontFamily: 'Righteous',
            ),
          ),
          Spacer(),
          Icon(
            Icons.arrow_forward_ios,
            color: Colors.white,
          )
        ],
      ),
    );
  }
}
