import 'package:equatable/equatable.dart';
import 'package:gift_of_the_nile/core/index.dart';
import 'package:gift_of_the_nile/data/index.dart';

class CharacterModel extends Equatable {
  const CharacterModel({
    this.gallery,
    this.name,
    required this.characterType,
    this.knownFor,
    this.id,
    this.animationName,
    this.animationPath,
    this.icon,
    this.appearedIn,
    this.date,
    this.videos,
    this.story,
  });

  final String? name;
  final CharacterType characterType;
  final String? knownFor;
  final int? id;
  final String? animationName;
  final String? icon;
  final String? animationPath;
  final String? story;
  final List<AppearanceModel>? appearedIn;
  final List<String>? gallery;
  final int? date;
  final List<String>? videos;

  @override
  List<Object?> get props => [
        name,
        characterType,
        knownFor,
        id,
        animationName,
        animationPath,
        icon,
        appearedIn,
        gallery,
        date,
        videos,
        story,
      ];
}
