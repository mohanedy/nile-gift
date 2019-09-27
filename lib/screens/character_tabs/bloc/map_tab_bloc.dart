import 'package:geolocator/geolocator.dart';
import 'package:gift_of_the_nile/models/ancient_gods.dart';
import 'package:gift_of_the_nile/services/location_service_provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rxdart/rxdart.dart';

class MapTabBloc {
  final _locService = LocationServiceProvider();
  final _locationsList = BehaviorSubject<List<Map<String, dynamic>>>();

  Observable<List<Map<String, dynamic>>> get locationList =>
      _locationsList.stream;
  final AncientGodCharacter _currentCharacter;

  MapTabBloc(this._currentCharacter) {
    initData();
  }

  void initData() async {
    List<Map<String, dynamic>> locationsData = [];
    for (AppearedIn loc in _currentCharacter.appearedIn) {
      final distance = await _locService.getDistance(LatLng(loc.lat, loc.lon));
      final placeMark =
          await Geolocator().placemarkFromCoordinates(loc.lat, loc.lon);
      print(placeMark.first.name);
      locationsData.add({
        'distance': distance,
        'placemark': placeMark.first,
      });
    }
    _locationsList.sink.add(locationsData);
  }

  dispose() async {
    await _locationsList.drain();
    _locationsList.close();
  }
}
