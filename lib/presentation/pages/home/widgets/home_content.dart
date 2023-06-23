import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:gift_of_the_nile/index.dart';
import 'package:gift_of_the_nile/presentation/base/base_bloc_builder.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BaseBlocBuilder<HomeBloc, HomeState>(onSuccess: (context, state) {
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
                                      builder: (c) => TimelinePage()));
                            },
                            color: Colors.yellow.shade700,
                            tooltip: 'Egyptian Timeline',
                          ),
                        ),
                        Center(
                          child: Container(
                            height: 140,
                            child: Image.asset('assets/images/pyramids.png'),
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
                SizedBox(
                  height: 20,
                )
              ]),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CategoryWidget(
                      state.ancientGods.map((v) {
                        return Padding(
                          padding: const EdgeInsets.only(
                            left: 20.0,
                            right: 20,
                          ),
                          child: ItemWidget(
                            itemLabel: v.name ?? '',
                            onPressed: () {},
                            // onPressed: () {
                            //   Navigator.push(
                            //       context,
                            //       MaterialPageRoute(
                            //           builder: (c) => CharacterScreen(
                            //                 v,
                            //               )));
                            // },
                          ),
                        );
                      }).toList(),
                      animationName: 'Ra Animation',
                      flareImage: 'assets/animation/Ra.flr',
                      label: 'Egyptian Gods',
                      color: Colors.transparent,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CategoryWidget(
                      state.pharaohs.map((v) {
                        return Padding(
                          padding: const EdgeInsets.only(
                            left: 20.0,
                            right: 20,
                          ),
                          child: ItemWidget(
                            itemLabel: v.name ?? '',
                            onPressed: () {},
                            // onPressed: () => Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (c) => CharacterScreen(
                            //       v,
                            //     ),
                            //   ),
                            // ),
                          ),
                        );
                      }).toList(),
                      animationName: 'eye',
                      flareImage: 'assets/animation/pharoh.flr',
                      label: 'Egyptian Pharaohs',
                      color: Colors.transparent,
                    ),
                  ),
                  Divider(
                    height: 50,
                    thickness: 3,
                    endIndent: 20,
                    indent: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: RawMaterialButton(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.favorite,
                            color: Colors.red,
                            size: 30,
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
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (c) => FavoritesCharacters()));
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: RawMaterialButton(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.share,
                            size: 30,
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
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
