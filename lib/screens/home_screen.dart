import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gift_of_the_nile/bloc/home_screen_bloc.dart';
import 'package:gift_of_the_nile/component/sliver_floating_search.dart';
import 'package:gift_of_the_nile/models/ancient_gods.dart';
import 'package:gift_of_the_nile/models/pharaoh.dart';
import 'package:gift_of_the_nile/screens/character_screen.dart';
import 'package:gift_of_the_nile/screens/timeline_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeScreenBloc _bloc;

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

  bool isEgyptianGodsExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: StreamBuilder<bool>(
            stream: _bloc.isLoading,
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data == false) {
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
                      sliver: SliverSearchFloatingBar(
                        placeHolder: 'Search here',
                        onTextChanged: (txt) {},
                        controller: TextEditingController(),
                      ),
                    ),
                    SliverList(
                      delegate: SliverChildListDelegate([
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: StreamBuilder<AncientGods>(
                              stream: _bloc.ancientGods,
                              builder: (context, ancientGods) {
                                if (ancientGods.hasData)
                                  return CategoryWidget(
                                    ancientGods.data.characters.map((v) {
                                      return Padding(
                                        padding: const EdgeInsets.only(
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
                                    flareImage: 'resources/animation/Ra.flr',
                                    label: 'Egyptian Gods',
                                    onExpand: (val) {
                                      setState(() {
                                        isEgyptianGodsExpanded = val;
                                      });
                                    },
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
                                  padding: const EdgeInsets.all(8.0),
                                  child: CategoryWidget(
                                    pharaohs.data.characters.map((v) {
                                      return Padding(
                                        padding: const EdgeInsets.only(
                                          left: 20.0,
                                          right: 20,
                                        ),
                                        child: ItemWidget(
                                          itemLabel: v.name,
                                          onPressed: () {},
                                        ),
                                      );
                                    }).toList(),
                                    animationName: 'eye',
                                    flareImage:
                                        'resources/animation/pharoh.flr',
                                    label: 'Egyptian Pharaohs',
                                    onExpand: (val) {
                                      setState(() {});
                                    },
                                    color: Colors.transparent,
                                  ),
                                );
                              } else {
                                return Container();
                              }
                            }),
                      ]),
                    ),
                  ],
                );
              } else {
                return Center(child: CircularProgressIndicator());
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
