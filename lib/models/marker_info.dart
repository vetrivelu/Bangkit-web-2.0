import 'dart:convert';
import 'dart:html';

import 'package:bangkit/models/response.dart';
import 'package:bangkit/services/firebase.dart';
import "package:google_maps_flutter_platform_interface/src/types/location.dart";

FloodProneArea floodProneAreaFromJson(String str) => FloodProneArea.fromJson(json.decode(str));

String floodProneAreaToJson(FloodProneArea data) => json.encode(data.toJson());

class FloodProneArea {
  FloodProneArea({
    this.id,
    required this.street,
    required this.area,
    required this.state,
    required this.maxFloodLevel,
    required this.coordinates,
  });

  String? id;
  String street;
  String area;
  String state;
  double maxFloodLevel;
  GeoPoint coordinates;

  factory FloodProneArea.fromJson(Map<String, dynamic> json) => FloodProneArea(
        street: json["street"],
        area: json["area"],
        state: json["state"],
        maxFloodLevel: json["max_flood_level"].toDouble(),
        coordinates: json["coordinates"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() =>
      {"id": id, "street": street, "area": area, "state": state, "max_flood_level": maxFloodLevel, "coordinates": coordinates};

  LatLng get latlang => LatLng(coordinates.latitude, coordinates.longitude);

  static Future<Response> add(FloodProneArea floodProneArea) async {
    floodProneArea.id = DateTime.now().millisecondsSinceEpoch.toString();
    return floodProneAreas.doc(floodProneArea.id).set(floodProneArea.toJson()).then((value) {
      return Response.success("Area added sucessfully");
    }).catchError((error) {
      return Response.error(error);
    });
  }

  get docId => latlang.toString();

  delete() {
    floodProneAreas
        .doc(docId)
        .delete()
        .then((value) => Response.success("Deleted sccessfully"))
        .onError((error, stackTrace) => Response.error(error));
  }
}

RetentionPond retentionPondsFromJson(String str) => RetentionPond.fromJson(json.decode(str));

String retentionPondsToJson(RetentionPond data) => json.encode(data.toJson());

class RetentionPond {
  String? id;

  RetentionPond({this.id, required this.name, required this.location, required this.depth, required this.maxRain, required this.coordinates});

  String name;
  String location;
  String depth;
  String maxRain;
  GeoPoint coordinates;

  factory RetentionPond.fromJson(Map<String, dynamic> json) => RetentionPond(
        name: json["name"],
        location: json["location"],
        depth: json["depth"],
        maxRain: json["max_rain"],
        coordinates: json["coordinates"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "location": location,
        "depth": depth,
        "max_rain": maxRain,
        "coordinates": coordinates,
      };

  static Future<Response> add(RetentionPond retentionPond) async {
    retentionPond.id = DateTime.now().millisecondsSinceEpoch.toString();
    return retentionPonds.doc(retentionPond.id).set(retentionPond.toJson()).then((value) {
      return Response.success("Pond added sucessfully");
    }).catchError((error) {
      return Response.error(error);
    });
  }

  delete() {
    return retentionPonds
        .doc(id)
        .delete()
        .then((value) => Response.success("Deleted Successfully"))
        .onError((error, stackTrace) => Response.error(error));
  }

  LatLng get latlang => LatLng(coordinates.latitude, coordinates.longitude);
  get docId => latlang.toString();
}

class ReservedArea {
  ReservedArea({
    this.id,
    required this.street,
    required this.area,
    required this.state,
    required this.coordinates,
  });

  String? id;
  String street;
  String area;
  String state;
  GeoPoint coordinates;

  factory ReservedArea.fromJson(Map<String, dynamic> json) => ReservedArea(
        street: json["street"],
        area: json["area"],
        state: json["state"],
        coordinates: json["coordinates"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {"id": id, "street": street, "area": area, "state": state, "coordinates": coordinates};

  LatLng get latlang => LatLng(coordinates.latitude, coordinates.longitude);

  static Future<Response> add(ReservedArea reservedArea) async {
    reservedArea.id = DateTime.now().millisecondsSinceEpoch.toString();
    return reservedAreas.doc(reservedArea.id).set(reservedArea.toJson()).then((value) {
      return Response.success("Area added sucessfully");
    }).catchError((error) {
      return Response.error(error);
    });
  }

  get docId => latlang.toString();

  delete() {
    reservedAreas.doc(docId).delete().then((value) => Response.success("Deleted sccessfully")).onError((error, stackTrace) => Response.error(error));
  }
}
