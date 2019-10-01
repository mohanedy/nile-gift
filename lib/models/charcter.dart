import 'package:gift_of_the_nile/constants.dart';

class Characters {
  final List<Character> characters;
  final String type;

  Characters(this.characters, this.type);
}

class Character {
  final String name;
  final CharacterType characterType;
  final String knownFor;
  final int id;
  final String animationName;
  final String animationPath;

  Character(this.name, this.characterType, this.knownFor, this.id,
      this.animationName, this.animationPath);
}
