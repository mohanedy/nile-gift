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
      asset: json['asset'],
      value: json['value'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['asset'] = this.asset;
    data['value'] = this.value;
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
