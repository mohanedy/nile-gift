import 'package:gift_of_the_nile/constants.dart';
import 'package:gift_of_the_nile/models/ancient_gods.dart';
import 'package:gift_of_the_nile/models/charcter.dart';

class Pharaohs implements Characters {
  List<Pharaoh> characters;
  String type;

  Pharaohs({this.characters, this.type});

  factory Pharaohs.fromJson(Map<String, dynamic> json) {
    return Pharaohs(
      characters: json['characters'] != null
          ? (json['characters'] as List)
              .map((i) => Pharaoh.fromJson(i))
              .toList()
          : null,
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    if (this.characters != null) {
      data['characters'] = this.characters.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Pharaoh implements Character {
  String about;
  String animationName;
  String animationPath;
  List<AppearedIn> appearedIn;
  String born;
  String burial;
  List<String> children;
  List<String> consort;
  String died;
  int dynasty;
  List<String> facts;
  String from;
  List<String> gallery;
  String icon;
  int id;
  String knowMore;
  String knownBy;
  String name;
  List<String> parents;
  String predecessor;
  String story;
  String successor;
  String to;
  List<String> videos;

  Pharaoh(
      {this.about,
      this.animationName,
      this.animationPath,
      this.appearedIn,
      this.born,
      this.burial,
      this.children,
      this.consort,
      this.died,
      this.dynasty,
      this.facts,
      this.from,
      this.gallery,
      this.icon,
      this.id,
      this.knowMore,
      this.knownBy,
      this.name,
      this.parents,
      this.videos,
      this.predecessor,
      this.story,
      this.successor,
      this.to});

  factory Pharaoh.fromJson(Map<String, dynamic> json) {
    return Pharaoh(
      about: json['about'],
      animationName: json['animation_name'],
      animationPath: json['animation_path'],
      appearedIn: json['appeared_in'] != null
          ? (json['appeared_in'] as List)
              .map((i) => AppearedIn.fromJson(i))
              .toList()
          : null,
      born: json['born'],
      burial: json['burial'],
      children: json['children'] != null
          ? new List<String>.from(json['children'])
          : null,
      consort: json['consort'] != null
          ? new List<String>.from(json['consort'])
          : null,
      died: json['died'],
      dynasty: json['dynasty'],
      videos:
          json['videos'] != null ? new List<String>.from(json['videos']) : [],
      facts:
          json['facts'] != null ? new List<String>.from(json['facts']) : null,
      from: json['from'],
      gallery: json['gallery'] != null
          ? new List<String>.from(json['gallery'])
          : null,
      icon: json['icon'],
      id: json['id'],
      knowMore: json['know_more'],
      knownBy: json['known_by'],
      name: json['name'],
      parents: json['parents'] != null
          ? new List<String>.from(json['parents'])
          : null,
      predecessor: json['predecessor'],
      story: json['story'],
      successor: json['successor'],
      to: json['to'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['about'] = this.about;
    data['animation_name'] = this.animationName;
    data['animation_path'] = this.animationPath;
    data['born'] = this.born;
    data['burial'] = this.burial;
    data['died'] = this.died;
    data['dynasty'] = this.dynasty;
    data['from'] = this.from;
    data['icon'] = this.icon;
    data['id'] = this.id;
    data['know_more'] = this.knowMore;
    data['known_by'] = this.knownBy;
    data['name'] = this.name;
    data['predecessor'] = this.predecessor;
    data['story'] = this.story;
    data['successor'] = this.successor;
    data['to'] = this.to;
    if (this.appearedIn != null) {
      data['appeared_in'] = this.appearedIn.map((v) => v.toJson()).toList();
    }
    if (this.children != null) {
      data['children'] = this.children;
    }
    if (this.consort != null) {
      data['consort'] = this.consort;
    }
    if (this.facts != null) {
      data['facts'] = this.facts;
    }
    if (this.gallery != null) {
      data['gallery'] = this.gallery;
    }
    if (this.parents != null) {
      data['parents'] = this.parents;
    }
    return data;
  }

  @override
  int get date => int.parse(from.replaceAll('BC', '').replaceAll('AD', ''));

  @override
  // TODO: implement characterType
  CharacterType get characterType => CharacterType.EgyptianPharaohs;

  @override
  // TODO: implement knownFor
  String get knownFor => knownBy;
}
