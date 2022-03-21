import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:bangkit/models/area.dart';
import 'package:bangkit/services/firebase.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter_web/google_maps_flutter_web.dart';

import 'mapview.dart';

class AllMap extends StatefulWidget {
  AllMap({Key? key}) : super(key: key);

  @override
  State<AllMap> createState() => _AllMapState();
}

class _AllMapState extends State<AllMap> {
  final gmaps = GoogleMapsPlugin();
  late int mapId;
  List<Marker> markers = [];
  List<Marker> _prevMarkers = [];
  LatLng? initPosistion;
  bool isFirst = true;

  @override
  void initState() {
    super.initState();
    mapId = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: areas.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active &&
              snapshot.hasData) {
            List<QueryDocumentSnapshot<Map<String, dynamic>>> documents =
                snapshot.data!.docs;
            List<Area> areas =
                documents.map((e) => Area.fromJson(e.data())).toList();
            markers.clear();
            markers = areas
                .map((e) => e.getMarker(() {
                      Get.to(() => AreaView(area: e));
                    }))
                .toList();

            markers.add(Marker(
                consumeTapEvents: true,
                markerId: const MarkerId("test Marker"),
                position: const LatLng(0.0, 0.0),
                icon: BitmapDescriptor.defaultMarker,
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return const Text("I am tapped");
                      });
                }));

            print("markers initiated");

            // return Marker(
            //     markerId: MarkerId(e.id.toString()),
            //     position: e.latlang,
            //     icon: e.markerIcon,
            //     consumeTapEvents: true,
            //     infoWindow: InfoWindow(title: e.location.toString(), onTap: () => Get.to(() => AreaView(area: e))),
            //     onTap: () {

            //     },);

            if (markers.isNotEmpty) {
              initPosistion = getAveragePosistion();
            } else {
              initPosistion = const LatLng(3.140853, 101.693207);
            }

            // if (!isFirst) {
            //   print("markers upadtING");
            //   gmaps
            //       .updateMarkers(MarkerUpdates.from(_prevMarkers.toSet(), markers.toSet()), mapId: mapId)
            //       .onError((error, stackTrace) => print(error));
            // }

            return gmaps.buildView(mapId++, (id) {
              isFirst = false;

              id != 0 ? gmaps.dispose(mapId: id - 1) : doNothing();
              gmaps.onTap(mapId: id).listen((event) {
                _prevMarkers = markers;
                Get.to(() => AreaView(
                      coordinates: event.position,
                    ));
              });
            },
                // gestureRecognizers: ,
                initialCameraPosition: const CameraPosition(
                  target: LatLng(3.140853, 101.693207),
                  zoom: 9,
                ),
                markers: markers.toSet());
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  LatLng? getAveragePosistion() {
    double latitude = 0;
    double longitude = 0;
    for (var marker in markers) {
      latitude += marker.position.latitude;
      longitude += marker.position.longitude;
    }
    var average = LatLng(latitude / markers.length, longitude / markers.length);
    return average;
  }
}

doNothing() {}
