import 'package:bangkit/models/area.dart';
import 'package:bangkit/screens/maps/all_items_map.dart';
import 'package:bangkit/services/firebase.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'dart:ui' as ui;
import 'dart:typed_data';
import "package:google_maps_flutter_platform_interface/src/types/bitmap.dart";

class IndexController extends GetxController {
  static IndexController instance = Get.find();
  int pageNumber = 0;
  void Function(int)? load;
}

class DamLinkController extends GetxController {
  static DamLinkController instance = Get.find();
  Map<String, dynamic>? links = {};

  loadlinks() async {
    links = await damLinks.get().then((value) => value.data());
  }

  @override
  void refresh() {
    super.refresh();
    loadlinks();
  }

  @override
  void onInit() {
    super.onInit();
    loadlinks();
  }
}

class MapIconsController extends GetxController {
  static MapIconsController instance = Get.find();
  Uint8List? floodMarkerIcon;
  Uint8List? retentionPondIcon;
  Uint8List? reservedLandIcon;

  BitmapDescriptor? marker1;
  BitmapDescriptor? marker2;
  BitmapDescriptor? marker3;

  loadIcons() async {
    // retentionPondIcon = await getBytesFromAsset("assets/pondICon.png", 10);
    // reservedLandIcon = await getBytesFromAsset("assets/ReserveIcon.png", 10);
    // floodMarkerIcon = await getBytesFromAsset("assets/FloodIcon.png", 10);

    marker1 = await BitmapDescriptor.fromAssetImage(const ImageConfiguration(size: Size(40, 40)), 'assets/FloodIcon.png');
    marker2 = await BitmapDescriptor.fromAssetImage(const ImageConfiguration(size: Size(40, 40)), 'assets/PondIcon.png');
    marker3 = await BitmapDescriptor.fromAssetImage(const ImageConfiguration(size: Size(40, 40)), 'assets/ReserveIcon.png');
  }

  static Map<String, dynamic> markerInfo = {};
  static loadMarkerInfo() async {
    var document = await markerInfos.get();
    markerInfo = document.exists ? document.data() : doNothing();
  }

  get floodfields => markerInfo["FloodProneArea"];
  get reservedFields => markerInfo["Reserved Area"];
  get pondFields => markerInfo["RetentionPonds"];
}

Future<Uint8List> getBytesFromAsset(String path, int width) async {
  ByteData data = await rootBundle.load(path);
  ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width, targetHeight: width);
  ui.FrameInfo fi = await codec.getNextFrame();
  return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
}

MapIconsController markerController = MapIconsController.instance;
