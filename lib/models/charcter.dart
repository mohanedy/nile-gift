import 'package:gift_of_the_nile/constants.dart';
import 'package:gift_of_the_nile/models/ancient_gods.dart';

class AppCharacters {
  final List<Character> characters;
  final String type;

  AppCharacters(this.characters, this.type);
}

class Character {
  final String name;
  final CharacterType characterType;
  final String knownFor;
  final int id;
  final String animationName;
  final String icon;
  final String animationPath;
  final String story;
  final List<AppearedIn> appearedIn;
  final List<String> gallery;
  final int date;
  final List<String> videos;

  Character(
      this.gallery,
      this.name,
      this.characterType,
      this.knownFor,
      this.id,
      this.animationName,
      this.animationPath,
      this.icon,
      this.appearedIn,
      this.date,
      this.videos,
      this.story);
}
