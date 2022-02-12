// ignore_for_file: implementation_imports
import 'package:bangkit/models/geocoding.dart';
import 'package:http/http.dart' as http;
import 'package:bangkit/controllers/page_controller.dart';
import 'package:bangkit/models/response.dart';
import 'package:bangkit/services/firebase.dart';
import "package:google_maps_flutter_platform_interface/src/types/location.dart";
import 'package:google_maps_flutter_platform_interface/src/types/marker.dart';
import 'package:google_maps_flutter_platform_interface/src/types/bitmap.dart';

class Area {
  Area({
    this.id,
    required this.property,
    required this.coordinates,
    required this.type,
    this.location,
  });

  String? id;
  Map<String, dynamic> property;
  GeoPoint coordinates;
  AreaType type;
  String? location;

  factory Area.fromJson(Map<String, dynamic> json) => Area(
        id: json["id"],
        property: json["property"],
        coordinates: json["coordinates"],
        type: AreaType.values.elementAt(json["type"]),
        location: json["location"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "property": property,
        "coordinates": coordinates,
        "type": type.index,
        "location": location,
      };

  LatLng get latlang => LatLng(coordinates.latitude, coordinates.longitude);

  String get docId => DateTime.now().millisecondsSinceEpoch.toString();

  Marker get marker => Marker(markerId: MarkerId(id.toString()), position: latlang, icon: markerIcon);

  Marker getMarker(void Function()? callback) => Marker(markerId: MarkerId(id.toString()), position: latlang, icon: markerIcon, onTap: callback);

  BitmapDescriptor get markerIcon {
    switch (type) {
      case AreaType.floodProne:
        // return BitmapDescriptor.fromBytes(markerController.floodMarkerIcon!);
        return markerController.marker1!;
      case AreaType.retentionPond:
        return markerController.marker2!;
      // return BitmapDescriptor.fromBytes(markerController.retentionPondIcon!);
      case AreaType.reserved:
        return markerController.marker3!;
      // return BitmapDescriptor.fromBytes(markerController.reservedLandIcon!);
      default:
        return BitmapDescriptor.defaultMarker;
    }
  }

  static Future<Result?> getAddress(latitude, longitude) async {
    var apiKey = "AIzaSyA68AkItTnbUcIo7FTn-lN1nOdeBmKEpds";
    var url = "https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=$apiKey";
    var uri = Uri.parse(url);
    var response = await http.get(uri);
    var body = jsonDecode(response.body);
    var results = body["results"].map((e) => Result.fromJson(e)).toList();
    print(results.first.toJson());
    return results.first;
  }

  Future<Response> add() async {
    id = docId;
    for (var element in property.values) {
      if (element.toString().isEmpty) {
        return Response.error("Please fill all fields");
      }
    }
    return await areas
        .doc(docId)
        .set(toJson())
        .then((value) => Response.success("Location Added successfully"))
        .onError((error, stackTrace) => Response.error(error));
  }

  update() {
    areas
        .doc(docId)
        .set(toJson())
        .then((value) => Response.success("Location Updated successfully"))
        .onError((error, stackTrace) => Response.error(error));
  }

  delete() {
    areas.doc(id).delete().then((value) => Response.success("Location Deleted sccessfully")).onError((error, stackTrace) => Response.error(error));
  }
}

enum AreaType { floodProne, retentionPond, reserved }
