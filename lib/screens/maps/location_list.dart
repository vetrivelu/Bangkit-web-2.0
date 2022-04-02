import 'package:bangkit/constants/themeconstants.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:bangkit/models/area.dart';
import 'package:bangkit/services/firebase.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter_web/google_maps_flutter_web.dart';

import 'mapview.dart';

class LocationList extends StatefulWidget {
  const LocationList({Key? key}) : super(key: key);

  @override
  State<LocationList> createState() => _LocationListState();
}

class _LocationListState extends State<LocationList> {
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
      appBar: AppBar(
        title: Text('Location List',style: getText(context).headline6,),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.to(() => AreaView());
          },
          child: const Icon(Icons.add)),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: areas.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active && snapshot.hasData) {
            List<QueryDocumentSnapshot<Map<String, dynamic>>> documents = snapshot.data!.docs;
            List<Area> areas = documents.map((e) => Area.fromJson(e.data())).toList();
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(
                height: getHeight(context)*0.85,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                        itemCount: areas.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(areas[index].property['Name'] ??
                                (areas[index].coordinates.latitude.toString() + ',' + areas[index].coordinates.longitude.toString())),
                            subtitle: Text(areas[index].location.toString()),
                            leading: IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () {
                                Get.to(() => AreaView(
                                      area: areas[index],
                                    ));
                              },
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                print("Hello");
                                areas[index].delete();
                              },
                            ),
                          );
                        }),
                  ),
                ),
              ),
            );
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
