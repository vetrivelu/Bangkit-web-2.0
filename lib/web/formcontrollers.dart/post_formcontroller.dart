import 'dart:typed_data';

import 'package:bangkit/models/aid_and_grant.dart';

import 'package:bangkit/services/firebase.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker_web/image_picker_web.dart';

import '../../constants/postal_codes.dart';
import '../../models/response.dart';

class PostFormController {
  int? id;
  String? title;
  String? description;
  List<String> media = [];
  List<String> attachments = [];
  List<String> videos = [''];

  List<Uint8List> _fileData = [];

  String? name;
  String? address;
  String? state;
  String? pincode;
  String? phone;
  String? email;
  DateTime? created;

  PostFormController({
    this.id,
    this.title,
    this.description,
    this.name,
    this.address,
    this.pincode,
    this.state,
    this.email,
    this.phone,
    this.created,
  });

  List<Uint8List>? imageData = [];
  List<PlatformFile> platformFiles = [];

  Future<List<Uint8List>?> imagePicker() async {
    List<Uint8List> temp = (await ImagePickerWeb.getMultiImagesAsBytes()) ?? [];
    imageData?.addAll(temp);
    return imageData;
  }

  Future<void> filePicker() async {
    var _tempFiles;
    FilePickerResult? temp = await FilePicker.platform.pickFiles();
    platformFiles.addAll((temp?.files) ?? []);
    return;
  }

  List<DropdownMenuItem<String>> get stateItems => PostalCodes.data.keys
      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
      .toList();

  List<DropdownMenuItem<String>> get postalCodeItems =>
      PostalCodes.getCodes(state ?? PostalCodes.data.keys.first)
          .map((e) =>
              DropdownMenuItem(value: e.toString(), child: Text(e.toString())))
          .toList();

  Post get post => Post(
      id: id,
      title: title!,
      description: description!,
      name: name!,
      address: address!,
      state: state!,
      pincode: pincode!,
      phone: phone!,
      email: email!,
      media: media,
      attachments: attachments,
      videos: videos,
      created: created);

  Future<Response> add() {
    Future taskUploadImages, taskUploadFiles;
    taskUploadFiles =
        Future.wait(platformFiles.map((e) => uploadFiles(e.bytes!, e.name)))
            .then((value) {
      attachments = value;
    });
    taskUploadImages = Future.wait(imageData!.map((e) => uploadImage(
            e, "POST" + DateTime.now().millisecondsSinceEpoch.toString())))
        .then((value) {
      media = value;
    });

    return Future.wait([taskUploadImages, taskUploadFiles])
        .then((value) => Post.addPost(post));
  }

  Future<void> removeImage(String value) {
    try {
      storage.refFromURL(value).delete();
    } catch (e) {}
    media.remove(value);
    return posts.doc(id.toString()).update({"media": media});
  }

  Future<void> removeAttachement(String value) {
    try {
      storage.refFromURL(value).delete();
    } catch (e) {}
    attachments.remove(value);
    return posts.doc(id.toString()).update({"attachments": attachments});
  }

  Future<Response> update() {
    Future taskUploadImages, taskUploadFiles;
    taskUploadFiles =
        Future.wait(platformFiles.map((e) => uploadFiles(e.bytes!, e.name)))
            .then((value) {
      attachments.addAll(value);
    });
    taskUploadImages = Future.wait(imageData!.map((e) => uploadImage(
            e, "POST" + DateTime.now().millisecondsSinceEpoch.toString())))
        .then((value) {
      media.addAll(value);
    });

    return Future.wait([taskUploadImages, taskUploadFiles])
        .then((value) => post.update());
  }

  factory PostFormController.fromPost(Post post) {
    PostFormController controller = PostFormController(
      id: post.id,
      title: post.title,
      description: post.description,
      name: post.name,
      address: post.address,
      state: post.state,
      pincode: post.pincode,
      email: post.email,
      phone: post.phone,
      created: post.created,
    );
    controller.media = post.media ?? [];
    controller.attachments = post.attachments ?? [];
    controller.videos = post.videos ?? [];
    return controller;
  }
}
