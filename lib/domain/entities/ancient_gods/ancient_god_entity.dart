import 'package:gift_of_the_nile/core/index.dart';
import 'package:gift_of_the_nile/domain/index.dart';

class AncientGodEntity extends CharacterEntity {
 final String? since;
 final String? about;
 final List<String>? believedIn;
 final List<String>? consort;
 final List<AbilitiesEntity>? godOf;
 final String? knowMore;
 final List<String>? parents;
 final List<String>? siblings;
 final String? symbol;

  const AncientGodEntity(
      {this.since,
      this.about,
      super.animationName,
      super.animationPath,
      super.appearedIn,
      this.believedIn,
      this.consort,
      super.gallery,
      this.godOf,
      super.id,
      this.knowMore,
      super.name,
      super.knownFor,
      this.parents,
      this.siblings,
      super.story,
      super.icon,
      super.videos,
      this.symbol})
      : super(characterType: CharacterType.EgyptianGod);



  @override
  int get date => int.parse((since?.replaceAll('BC', '') ?? '0'));
}
