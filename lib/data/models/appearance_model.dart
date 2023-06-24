import 'package:gift_of_the_nile/index.dart';

class AppearanceModel implements BaseModel<AppearanceEntity> {
  double lat;
  double lon;

  AppearanceModel({required this.lat, required this.lon});

  factory AppearanceModel.fromJson(Map<String, dynamic> json) {
    return AppearanceModel(
      lat: json['lat'] as double,
      lon: json['lon'] as double,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lat'] = lat;
    data['lon'] = lon;

    return data;
  }

  @override
  AppearanceEntity toEntity() {
    return AppearanceEntity(
      lat: lat,
      lon: lon,
    );
  }
}
