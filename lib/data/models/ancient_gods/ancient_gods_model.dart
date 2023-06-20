import 'package:gift_of_the_nile/data/models/ancient_gods/ancient_god_model.dart';
import 'package:gift_of_the_nile/data/models/characters_model.dart';

class AncientGodsModel extends CharactersModel<AncientGodModel> {
  const AncientGodsModel({super.characters, super.type});

  factory AncientGodsModel.fromJson(Map<String, dynamic> json) {
    return AncientGodsModel(
      characters: json['characters'] != null
          ? (json['characters'] as List)
              .map((i) => AncientGodModel.fromJson(i))
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
