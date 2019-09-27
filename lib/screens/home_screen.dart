import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:gift_of_the_nile/bloc/home_screen_bloc.dart';
import 'package:gift_of_the_nile/component/sliver_floating_search.dart';
import 'package:gift_of_the_nile/models/ancient_gods.dart';
import 'package:gift_of_the_nile/screens/character_screen.dart';

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
                            Container(
                              height: 140,
                              child: FlareActor(
                                'resources/animation/pharoh.flr',
                                animation: 'eye',
                              ),
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
                                          itemLabel: ancientGods
                                                  .data.characters[0].name +
                                              ' - ' +
                                              ancientGods
                                                  .data.characters[0].nickname,
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
                                    color: Colors.blueGrey,
                                  );
                                else
                                  return Container();
                              }),
                        ),
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
  final String flareImage;
  final String animationName;
  final String label;
  final List<Widget> items;
  final Color color;

  CategoryWidget(this.items,
      {this.flareImage, this.animationName, this.label, this.color});

  @override
  Widget build(BuildContext context) {
    return Material(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 10,
      color: color,
      child: ExpansionTile(
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
                  height: 150,
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
