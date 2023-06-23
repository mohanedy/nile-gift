import 'package:gift_of_the_nile/index.dart';

class AncientGodModel extends CharacterModel
    implements BaseModel<AncientGodEntity> {
  final String? since;
  final String? about;
  final List<String>? believedIn;
  final List<String>? consort;
  final List<AbilitiesModel>? godOf;
  final String? knowMore;
  final List<String>? parents;
  final List<String>? siblings;
  final String? symbol;

  const AncientGodModel(
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
      : super(characterType: CharacterType.ancientGod);

  factory AncientGodModel.fromJson(Map<String, dynamic> json) {
    return AncientGodModel(
      since: json['when'],
      about: json['about'],
      animationName: json['animation_name'],
      animationPath: json['animation_path'],
      appearedIn: json['appeared_in'] != null
          ? (json['appeared_in'] as List)
              .map((i) => AppearanceModel.fromJson(i))
              .toList()
          : null,
      believedIn: json['believed_in'] != null
          ? new List<String>.from(json['believed_in'])
          : null,
      consort: json['consort'] != null
          ? new List<String>.from(json['consort'])
          : null,
      gallery: json['gallery'] != null
          ? new List<String>.from(json['gallery'])
          : null,
      videos:
          json['videos'] != null ? new List<String>.from(json['videos']) : [],
      godOf: json['god_of'] != null
          ? (json['god_of'] as List)
              .map((i) => AbilitiesModel.fromJson(i))
              .toList()
          : null,
      id: json['id'],
      knowMore: json['know_more'],
      name: json['name'],
      knownFor: json['nickname'],
      parents: json['parents'] != null
          ? new List<String>.from(json['parents'])
          : null,
      siblings: json['siblings'] != null
          ? new List<String>.from(json['siblings'])
          : null,
      story: json['story'],
      symbol: json['symbol'],
      icon: json['icon'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['`when`'] = this.since;
    data['about'] = this.about;
    data['animation_name'] = this.animationName;
    data['animation_path'] = this.animationPath;
    data['id'] = this.id;
    data['know_more'] = this.knowMore;
    data['name'] = this.name;
    data['nickname'] = this.knownFor;
    data['story'] = this.story;
    data['symbol'] = this.symbol;
    if (this.appearedIn != null) {
      data['appeared_in'] = this.appearedIn!.map((v) => v.toJson()).toList();
    }
    if (this.believedIn != null) {
      data['believed_in'] = this.believedIn;
    }
    if (this.consort != null) {
      data['consort'] = this.consort;
    }
    if (this.gallery != null) {
      data['gallery'] = this.gallery;
    }
    if (this.godOf != null) {
      data['god_of'] = this.godOf!.map((v) => v.toJson()).toList();
    }
    if (this.parents != null) {
      data['parents'] = this.parents;
    }
    if (this.siblings != null) {
      data['siblings'] = this.siblings;
    }
    return data;
  }

  @override
  int get date => int.parse((since?.replaceAll('BC', '') ?? '0'));

  @override
  AncientGodEntity toEntity() {
    return AncientGodEntity(
      about: about,
      animationName: animationName,
      animationPath: animationPath,
      appearedIn: appearedIn!.map((e) => e.toEntity()).toList(),
      believedIn: believedIn,
      consort: consort,
      gallery: gallery,
      godOf: godOf?.map((e) => e.toEntity()).toList() ?? [],
      id: id,
      knowMore: knowMore,
      name: name,
      knownFor: knownFor,
      parents: parents,
      siblings: siblings,
      story: story,
      symbol: symbol,
      icon: icon,
      videos: videos,
    );
  }
}
