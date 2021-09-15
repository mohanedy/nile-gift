import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationServiceProvider {
  Future<Position> getCurrentLocation() async {
    return await Geolocator.getCurrentPosition().catchError((e) {
      print(e);
      print('exception');
    });
  }

  Future<double> getDistance(LatLng destination) async {
    try {
      final currentPosition = await getCurrentLocation();
      print(currentPosition.latitude);
      return await Geolocator.distanceBetween(
              currentPosition.latitude,
              currentPosition.longitude,
              destination.latitude,
              destination.longitude) *
          0.001;
    } catch (e) {
      print(e);
      print('exception');
    }
    return 0;
  }
}
