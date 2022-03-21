// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as file;
import 'dart:typed_data';
import 'package:bangkit/constants/postal_codes.dart';
import 'package:bangkit/models/adun.dart';
import 'package:flutter/material.dart';
import 'package:mime_type/mime_type.dart';
import 'package:path/path.dart';
import 'package:image_picker_web/image_picker_web.dart';

import '../../models/response.dart';
import '../../services/firebase.dart';

class AdunFormController {
  final name = TextEditingController();
  final address = TextEditingController();
  final phoneNumber = TextEditingController();
  final imageUrl = TextEditingController();
  final email = TextEditingController();
  final weburl = TextEditingController();
  final description = TextEditingController();

  int? id;
  String? state = PostalCodes.data.keys.first;
  String? federal;
  String? postCode =
      PostalCodes.getCodes(PostalCodes.data.keys.first).first.toString();
  String? image;

  file.File? _mediafile;
  Uint8List? _fileData;
  String? _fileName;

  set setState(String text) {
    state = text;
    federal = PostalCodes.federals[state]!.first;
    postCode = PostalCodes.data[state]!.first.toString();
  }

  Future<Response> add() async {
    if (fileData != null) {
      try {
        return uploadFile(fileData!, name.text).then((value) {
          image = value;
          return Adun.addAdun(adun!);
        });
      } catch (exception) {
        return Response.error(exception.toString());
      }
    }
    return Adun.addAdun(adun!);
  }

  Future<Response> update() async {
    if (fileData != null) {
      try {
        return uploadFile(fileData!, name.text).then((value) {
          storage.refFromURL(image ?? '').delete();
          image = value;
          return adun!.update();
        });
      } catch (exception) {
        print(exception.toString());
      }
    }
    return adun!.update();
  }

  clear() {
    name.clear();
    address.clear();
    phoneNumber.clear();
    imageUrl.clear();
    email.clear();
    weburl.clear();
    description.clear();

    id = null;
    image = null;
    setState = PostalCodes.data.keys.first;
    _mediafile = null;
    _fileData = null;
    _fileName = null;
  }

  String get firstState => PostalCodes.data.keys.first;

  List<DropdownMenuItem<String>> get stateItems => PostalCodes.data.keys
      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
      .toList();

  List<DropdownMenuItem<String>>
      get postalCodeItems => PostalCodes.getCodes(state!)
          .map((e) =>
              DropdownMenuItem(value: e.toString(), child: Text(e.toString())))
          .toList();

  List<DropdownMenuItem<String>>
      get federalItems => PostalCodes.getFederals(state!)
          .map((e) =>
              DropdownMenuItem(value: e.toString(), child: Text(e.toString())))
          .toList();

  AdunFormController({
    this.image,
    this.postCode,
    this.state,
    this.federal,
    this.id,
  });

  Uint8List? get fileData => _fileData;
  get fileName => _fileName;
  get mediafile => _mediafile;

  Future<void> imagePicker() async {
    var mediaInfo = await ImagePickerWeb.getImageInfo;
    if (mediaInfo.data != null && mediaInfo.fileName != null) {
      _fileData = mediaInfo.data;
      _fileName = mediaInfo.fileName;
      String? mimeType = mime(basename(mediaInfo.fileName.toString()));
      _mediafile =
          file.File(mediaInfo.data!, mediaInfo.fileName!, {'type': mimeType});
    }
    return;
  }

  Adun? get adun {
    if (state != null && federal != null && postCode != null) {
      return Adun(
        name: name.text,
        image: image ?? '',
        state: state!,
        contactNumber: phoneNumber.text,
        officeAddress: address.text,
        postCode: postCode!,
        emailAddress: email.text,
        description: description.text,
        weburl: weburl.text,
        federal: federal!,
        id: id,
      );
    } else {
      print("Danger!!!....returning null");
      return null;
    }
  }

  factory AdunFormController.fromAdun(Adun adun) {
    var controller = AdunFormController(
        id: adun.id,
        image: adun.image,
        postCode: adun.postCode,
        state: adun.state,
        federal: adun.federal);

    controller.name.text = adun.name;
    controller.address.text = adun.officeAddress;
    controller.phoneNumber.text = adun.contactNumber;
    controller.email.text = adun.emailAddress;
    controller.weburl.text = adun.weburl;
    controller.description.text = adun.description;
    controller.imageUrl.text = adun.image;

    return controller;
  }
}
