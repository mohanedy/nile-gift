import 'package:gift_of_the_nile/index.dart';

class AbilitiesModel implements BaseModel<AbilitiesEntity> {
  final String asset;
  final String value;

  const AbilitiesModel({
    required this.asset,
    required this.value,
  });

  factory AbilitiesModel.fromJson(Map<String, dynamic> json) {
    return AbilitiesModel(
      asset: json['asset'] as String,
      value: json['value'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['asset'] = asset;
    data['value'] = value;

    return data;
  }

  @override
  AbilitiesEntity toEntity() {
    return AbilitiesEntity(
      asset: asset,
      value: value,
    );
  }
}
