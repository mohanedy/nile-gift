class AppearanceModel {
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
}


