import 'dart:html' as file;
import 'dart:typed_data';
import 'package:bangkit/constants/controller_constants.dart';
import 'package:bangkit/constants/postal_codes.dart';
import 'package:bangkit/models/response.dart';
import 'package:bangkit/services/firebase.dart';
import 'package:flutter/material.dart';
import 'package:mime_type/mime_type.dart';
import 'package:path/path.dart';
import 'package:bangkit/models/ngo.dart';
import 'package:image_picker_web/image_picker_web.dart';

class NGOFormController {
  final name = TextEditingController();
  final contactPersonName = TextEditingController();
  final address = TextEditingController();
  final phoneNumber = TextEditingController();
  final email = TextEditingController();
  final urlWeb = TextEditingController();
  final urlSocialMedia = TextEditingController();
  final description = TextEditingController();
  int? id;
  String? image;
  EntityType? type;

  String? state = PostalCodes.data.keys.first;
  String? postCode =
      PostalCodes.getCodes(PostalCodes.data.keys.first).first.toString();

  String? service;
  file.File? _mediafile;
  Uint8List? _fileData;
  String? _fileName;

  clear() {
    name.clear();
    contactPersonName.clear();
    address.clear();
    phoneNumber.clear();
    email.clear();
    urlWeb.clear();
    urlSocialMedia.clear();
    description.clear();
    id = null;
    image = null;
    type = null;
    state = null;
    service = null;
    postCode = null;
    _mediafile = null;
    _fileData = null;
    _fileName = null;
  }

  List<DropdownMenuItem<String>> get stateItems => PostalCodes.data.keys
      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
      .toList();

  List<DropdownMenuItem<String>> get postalCodeItems =>
      PostalCodes.getCodes(state ?? PostalCodes.data.keys.first)
          .map((e) =>
              DropdownMenuItem(value: e.toString(), child: Text(e.toString())))
          .toList();

  NGOFormController({
    this.image,
    required this.type,
    this.postCode,
    this.state,
    this.id,
  });

  Uint8List? get fileData => _fileData;
  get fileName => _fileName;
  get mediafile => _mediafile;

  Future<Response> add() async {
    if (fileData != null) {
      try {
        return uploadImage(fileData!, name.text).then((value) {
          image = value;
          return Ngo.addNgo(object!);
        });
      } catch (exception) {
        print(exception.toString());
      }
    }
    return Ngo.addNgo(object!);
  }

  Future<Response> update() async {
    if (fileData != null) {
      try {
        return uploadImage(fileData!, name.text).then((value) {
          storage.refFromURL(image ?? '').delete();
          image = value;
          return object!.update();
        });
      } catch (exception) {
        print(exception.toString());
      }
    }
    return object!.update();
  }

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

  factory NGOFormController.plainNgo() =>
      NGOFormController(type: EntityType.private);
  factory NGOFormController.fromNgo(Ngo ngo) {
    var controller = NGOFormController(
      id: ngo.id,
      type: ngo.entityType ?? EntityType.private,
      image: ngo.image,
      postCode: ngo.postCode,
      state: ngo.state,
    );
    controller.name.text = ngo.name;
    controller.contactPersonName.text = ngo.contactPersonName;
    controller.address.text = ngo.address;
    controller.phoneNumber.text = ngo.phoneNumber;
    controller.email.text = ngo.email;
    controller.urlWeb.text = ngo.urlWeb;
    controller.urlSocialMedia.text = ngo.urlSocialMedia;
    controller.description.text = ngo.description;
    controller.service = ngo.service;
    return controller;
  }
  factory NGOFormController.plainAgency() =>
      NGOFormController(type: EntityType.government);
  factory NGOFormController.fromAgency(Ngo ngo) {
    var controller = NGOFormController(
      type: EntityType.government,
      image: ngo.image,
      postCode: ngo.postCode,
      state: ngo.state,
    );
    controller.name.text = ngo.name;
    controller.contactPersonName.text = ngo.contactPersonName;
    controller.address.text = ngo.address;
    controller.phoneNumber.text = ngo.phoneNumber;
    controller.email.text = ngo.email;
    controller.urlSocialMedia.text = ngo.urlSocialMedia;
    controller.description.text = ngo.description;
    return controller;
  }

  Ngo? get object => (postCode != null && state != null && service != null)
      ? Ngo(
          id: id,
          name: name.text,
          address: address.text,
          postCode: postCode!,
          state: state!,
          phoneNumber: phoneNumber.text,
          email: email.text,
          image: image ?? '',
          description: description.text,
          contactPersonName: contactPersonName.text,
          service: service!,
          urlWeb: urlWeb.text,
          urlSocialMedia: urlSocialMedia.text,
          entityType: type)
      : null;
}
