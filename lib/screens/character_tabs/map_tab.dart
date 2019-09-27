import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:gift_of_the_nile/constants.dart';
import 'package:gift_of_the_nile/models/ancient_gods.dart';
import 'package:gift_of_the_nile/screens/character_tabs/bloc/map_tab_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapTab extends StatefulWidget {
  final AncientGodCharacter _character;

  MapTab(this._character);

  @override
  _MapTabState createState() => _MapTabState();
}

class _MapTabState extends State<MapTab> {
  Completer<GoogleMapController> _controller = Completer();
  AncientGodCharacter _character;
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(26.8206, 30.8025),
  );
  MapTabBloc _bloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _character = widget._character;
    _bloc = MapTabBloc(_character);
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'You can find it in egypt at',
              style: kGreyTextStyle.copyWith(
                fontWeight: FontWeight.normal,
                fontSize: 17,
              ),
            ),
          ),
          StreamBuilder<List<Map<String, dynamic>>>(
              stream: _bloc.locationList,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.separated(
                    padding: EdgeInsets.only(left: 8, right: 8, bottom: 10),
                    physics: ClampingScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final distance =
                          snapshot.data[index]['distance'] as double;
                      final placeMark =
                          snapshot.data[index]['placemark'] as Placemark;
                      return Row(
                        children: <Widget>[
                          Material(
                            type: MaterialType.circle,
                            color: Colors.yellow.shade700,
                            elevation: 8,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 25,
                              ),
                              child: Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.location_on,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    '${distance.floor()} KM ',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(placeMark.administrativeArea,
                                  textAlign: TextAlign.start,
                                  style: kGreyTextStyle.copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal,
                                  )),
                              Text(
                                placeMark.subAdministrativeArea +
                                    ' - ' +
                                    placeMark.name,
                                textAlign: TextAlign.start,
                                style: kGreyTextStyle.copyWith(
                                  color: Colors.grey,
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                    separatorBuilder: (c, i) => Divider(),
                    itemCount: snapshot.data.length,
                  );
                } else {
                  return CircularProgressIndicator();
                }
              }),
          Container(
            height: MediaQuery.of(context).size.height / 2,
            child: GoogleMap(
              mapToolbarEnabled: true,
              mapType: MapType.normal,
              gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>[
                new Factory<OneSequenceGestureRecognizer>(
                  () => new EagerGestureRecognizer(),
                ),
              ].toSet(),
              initialCameraPosition: _kGooglePlex,
              markers: _character.appearedIn.map((v) {
                return Marker(
                  markerId: MarkerId('loc'),
                  position: LatLng(v.lat, v.lon),
                  visible: true,
                );
              }).toSet(),
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            ),
          ),
        ],
      ),
    );
  }
}
