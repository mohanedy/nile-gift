import 'package:gift_of_the_nile/data/models/base_model.dart';
import 'package:gift_of_the_nile/index.dart';

class AppearanceModel implements BaseModel<AppearanceEntity> {
  double lat;
  double lon;

  AppearanceModel({required this.lat, required this.lon});

  factory AppearanceModel.fromJson(Map<String, dynamic> json) {
    return AppearanceModel(
      lat: json['lat'],
      lon: json['lon'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lat'] = this.lat;
    data['lon'] = this.lon;
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
