import 'package:gift_of_the_nile/index.dart';

class PharaohModel extends CharacterModel implements BaseModel<PharaohEntity> {
  PharaohModel({
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
    super.knownFor,
    this.to,
  }) : super(characterType: CharacterType.pharaoh);

  String? about;
  String? born;
  String? burial;
  List<String>? children;
  List<String>? consort;
  String? died;
  int? dynasty;
  List<String>? facts;
  String? from;
  String? knowMore;
  String? knownBy;
  List<String>? parents;
  String? predecessor;
  String? successor;
  String? to;

  factory PharaohModel.fromJson(Map<String, dynamic> json) {
    return PharaohModel(
      about: json['about'],
      animationName: json['animation_name'],
      animationPath: json['animation_path'],
      appearedIn: json['appeared_in'] != null
          ? (json['appeared_in'] as List)
              .map((i) => AppearanceModel.fromJson(i))
              .toList()
          : null,
      born: json['born'],
      burial: json['burial'],
      children: json['children'] != null
          ? List<String>.from(json['children'])
          : null,
      consort: json['consort'] != null
          ? List<String>.from(json['consort'])
          : null,
      died: json['died'],
      dynasty: json['dynasty'],
      videos:
          json['videos'] != null ? List<String>.from(json['videos']) : [],
      facts:
          json['facts'] != null ? List<String>.from(json['facts']) : null,
      from: json['from'],
      gallery: json['gallery'] != null
          ? List<String>.from(json['gallery'])
          : null,
      icon: json['icon'],
      id: json['id'],
      knowMore: json['know_more'],
      knownBy: json['known_by'],
      knownFor: json['known_by'],
      name: json['name'],
      parents: json['parents'] != null
          ? List<String>.from(json['parents'])
          : null,
      predecessor: json['predecessor'],
      story: json['story'],
      successor: json['successor'],
      to: json['to'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['about'] = about;
    data['animation_name'] = animationName;
    data['animation_path'] = animationPath;
    data['born'] = born;
    data['burial'] = burial;
    data['died'] = died;
    data['dynasty'] = dynasty;
    data['from'] = from;
    data['icon'] = icon;
    data['id'] = id;
    data['know_more'] = knowMore;
    data['known_by'] = knownBy;
    data['name'] = name;
    data['predecessor'] = predecessor;
    data['story'] = story;
    data['successor'] = successor;
    data['to'] = to;
    if (appearedIn != null) {
      data['appeared_in'] = appearedIn!.map((v) => v.toJson()).toList();
    }
    if (children != null) {
      data['children'] = children;
    }
    if (consort != null) {
      data['consort'] = consort;
    }
    if (facts != null) {
      data['facts'] = facts;
    }
    if (gallery != null) {
      data['gallery'] = gallery;
    }
    if (parents != null) {
      data['parents'] = parents;
    }
    return data;
  }

  @override
  int get date =>
      int.parse(from?.replaceAll('BC', '').replaceAll('AD', '') ?? '0');

  @override
  PharaohEntity toEntity() {
    return PharaohEntity(
      about: about,
      animationName: animationName,
      animationPath: animationPath,
      appearedIn: appearedIn?.map((e) => e.toEntity()).toList(),
      born: born,
      burial: burial,
      children: children,
      consort: consort,
      died: died,
      dynasty: dynasty,
      facts: facts,
      from: from,
      gallery: gallery,
      icon: icon,
      id: id,
      knowMore: knowMore,
      knownBy: knownBy,
      name: name,
      parents: parents,
      predecessor: predecessor,
      story: story,
      successor: successor,
      to: to,
      videos: videos,
      knownFor: knownFor,
      date: date,
    );
  }
}
