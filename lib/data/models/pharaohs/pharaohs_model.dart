import 'package:gift_of_the_nile/index.dart';


class PharaohsModel extends CharactersModel<PharaohModel> implements BaseModel<PharaohsEntity> {

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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    if (characters != null) {
      data['characters'] = characters!.map((v) => v.toJson()).toList();
    }
    return data;
  }
  
  @override
  PharaohsEntity toEntity() {
    return PharaohsEntity(
      characters: characters!.map((e) => e.toEntity()).toList(),
      type: type,
    );
  }
}
