import 'package:gift_of_the_nile/data/index.dart';


class PharaohsModel extends CharactersModel<PharaohModel> {

  const PharaohsModel({super.characters, super.type});

  factory PharaohsModel.fromJson(Map<String, dynamic> json) {
    return PharaohsModel(
      characters: json['characters'] != null
          ? (json['characters'] as List)
              .map((i) => PharaohModel.fromJson(i))
              .toList()
          : null,
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    if (this.characters != null) {
      data['characters'] = this.characters!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}