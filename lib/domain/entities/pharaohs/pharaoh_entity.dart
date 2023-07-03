import 'package:equatable/equatable.dart';
import 'package:gift_of_the_nile/core/index.dart';
import 'package:gift_of_the_nile/domain/index.dart';

class PharaohEntity extends CharacterEntity {
  const PharaohEntity({
    this.about,
    super.animationName,
    super.animationPath,
    super.appearedIn,
    this.born,
    this.burial,
    this.children,
    this.consort,
    this.died,
    this.dynasty,
    this.facts,
    this.from,
    super.gallery,
    super.icon,
    super.id,
    this.knowMore,
    this.knownBy,
    super.name,
    this.parents,
    super.videos,
    this.predecessor,
    super.story,
    this.successor,
    this.to,
    super.knownFor,
    super.date,
  }) : super(characterType: CharacterType.pharaoh);

  final String? about;
  final String? born;
  final String? burial;
  final List<String>? children;
  final List<String>? consort;
  final String? died;
  final int? dynasty;
  final List<String>? facts;
  final String? from;
  final String? knowMore;
  final String? knownBy;
  final List<String>? parents;
  final String? predecessor;
  final String? successor;
  final String? to;

  @override
  int get date =>
      int.parse(from?.replaceAll('BC', '').replaceAll('AD', '') ?? '0');
}
