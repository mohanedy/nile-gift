import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:gift_of_the_nile/component/loading_progress.dart';
import 'package:gift_of_the_nile/models/charcter_entity.dart';
import 'package:gift_of_the_nile/screens/character_screen.dart';
import 'package:gift_of_the_nile/services/data_service_provider.dart';
import 'package:koukicons/disliked.dart';

class FavoritesCharacters extends StatefulWidget {
  @override
  _FavoritesCharactersState createState() => _FavoritesCharactersState();
}

class _FavoritesCharactersState extends State<FavoritesCharacters> {
  final _provider = DataServiceProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Your Favorites',
          style: TextStyle(
            color: Colors.amber,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.amber,
          ),
        ),
      ),
      body: FutureBuilder<List<Character>>(
          future: _provider.getLikedCharacters(context),
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data.length > 0) {
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    final character = snapshot.data[index];
                    return CharacterListWidget(character: character);
                  },
                  separatorBuilder: (context, index) {
                    return Divider();
                  },
                  itemCount: snapshot.data.length,
                ),
              );
            } else if (snapshot.hasData && snapshot.data.length == 0) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  KoukiconsDisliked(
                    height: 100,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    'You haven\'t favorited anything yet.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                ],
              );
            } else {
              return Center(
                child: LoadingProgress(),
              );
            }
          }),
    );
  }
}

class CharacterListWidget extends StatelessWidget {
  const CharacterListWidget({
    Key key,
    @required this.character,
  }) : super(key: key);

  final Character character;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (c) => CharacterScreen(character)));
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          CircleAvatar(
            backgroundColor: Colors.white,
            maxRadius: 40,
            minRadius: 30,
            child: character.icon != null
                ? Image.asset(
                    'resources/' + character.icon,
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                  )
                : FlareActor(
                    'resources/animation/' + character.animationPath,
                    animation: character.animationName,
                    alignment: Alignment.center,
                    fit: BoxFit.scaleDown,
                  ),
          ),
          SizedBox(
            width: 10,
          ),
          Column(
            children: <Widget>[
              Text(
                character.name,
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 19,
                ),
              ),
              Text(
                character.date.toString() + ' BC',
                textAlign: TextAlign.start,
              ),
            ],
          )
        ],
      ),
    );
  }
}
