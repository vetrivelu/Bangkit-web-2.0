// To parse this JSON data, do
//
//     final profile = profileFromJson(jsonString);

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:bangkit/constants/controller_constants.dart';
import 'package:bangkit/models/response.dart';
import 'package:bangkit/services/firebase.dart';
import 'package:flutter/cupertino.dart';

Profile profileFromJson(String str) => Profile.fromJson(json.decode(str));

String profileToJson(Profile data) => json.encode(data.toJson());

class Profile {
  Profile(
      {this.uid,
      required this.name,
      required this.phone,
      required this.secondaryPhone,
      required this.email,
      required this.primaryAddress,
      required this.secondaryAddress,
      this.isVolunteer = false,
      this.isApproved = false,
      this.about = '',
      required this.fcm,
      required this.documents,
      required this.icNumber,
      required this.services});

  String? uid;
  String name;
  String phone;
  String secondaryPhone;
  String email;
  String icNumber;
  String fcm;
  bool isVolunteer;
  bool isApproved;
  Address primaryAddress;
  Address secondaryAddress;
  List<dynamic> documents;
  String? about;
  List<dynamic> services;

  static List<String> emptyString = [];

  get searchService {
    Map<String, dynamic> json = {};
    for (var element in services) {
      json["$element"] = true;
    }
    return json;
  }

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        uid: json["uid"],
        name: json["name"],
        phone: json["phone"],
        secondaryPhone: json["secondaryPhone"],
        email: json["email"],
        primaryAddress: Address.fromJson(json["primaryAddress"]),
        isVolunteer: json["isVolunteer"] ?? false,
        isApproved: json["isApproved"] ?? false,
        secondaryAddress: Address.fromJson(json["secondaryAddress"]),
        about: json["about"] ?? '',
        icNumber: json["icNumber"] ?? '',
        documents: json["documents"] ?? emptyString,
        services: json["services"] ?? [],
        fcm: json['fcm'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "name": name,
        "phone": phone,
        "icNumber": icNumber,
        "secondaryPhone": secondaryPhone,
        "isVolunteer": isVolunteer,
        "isApproved": isApproved,
        "email": email,
        "primaryAddress": primaryAddress.toJson(),
        "secondaryAddress": secondaryAddress.toJson(),
        "about": about ?? '',
        "documents": documents,
        "services": services,
        "searchService": searchService,
        primaryAddress.state: true,
        secondaryAddress.state: true,
        primaryAddress.pincode: true,
        secondaryAddress.pincode: true,
      };

  Future<Response> addUser(String uid) async {
    this.uid = uid;
    return await users
        .doc(uid)
        .set(toJson())
        .then((value) => Response(code: "Sucess", message: "Your Profile has been Submitted Successfuly"))
        .catchError((error) {
      return Response(code: "Failed", message: error.toString());
    });
  }

  Future<Response> updateUser() {
    return users
        .doc(uid)
        .update(toJson())
        .then((value) => Response(code: "Success", message: "Your profile has been updated successfully"))
        .catchError((error) {
      return Response(code: "Failed", message: error.toString());
    });
  }

  approveVolunteer() {
    return users.doc(uid).update({"isApproved": true}).then((value) {
      HttpsCallable callable = functions.httpsCallable('sendVolunteerApprovedNotification');
      callable.call({"token": fcm}).then((value) => Response.success("Approved succesfullly"));
    });
  }

  static Stream<DocumentSnapshot<Map<String, dynamic>>> getUserProfileAsStream(String uid) {
    return users.doc(uid).snapshots();
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> getCurrentUserasStream() {
    return getUserProfileAsStream(authController.auth.currentUser!.uid);
  }
}

class Address {
  Address({
    required this.line1,
    required this.line2,
    required this.description,
    required this.roofColor,
    required this.doorColor,
    required this.state,
    required this.pincode,
  });

  String line1;
  String line2;
  String state;
  String pincode;
  String description;
  String roofColor;
  String doorColor;

  get fullAddress => line1 + ", " + line2 + ", " + state + ", " + pincode;

  static get plainController => AdressEditingController(
        line1: TextEditingController(),
        line2: TextEditingController(),
        state: TextEditingController(),
        pincode: TextEditingController(),
        description: TextEditingController(),
        roofColor: TextEditingController(),
        doorColor: TextEditingController(),
      );

  AdressEditingController get controller => AdressEditingController(
        line1: TextEditingController(text: line1),
        line2: TextEditingController(text: line2),
        state: TextEditingController(text: state),
        pincode: TextEditingController(text: pincode),
        description: TextEditingController(text: description),
        roofColor: TextEditingController(text: roofColor),
        doorColor: TextEditingController(text: doorColor),
      );

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        line1: json["line1"],
        line2: json["line2"],
        description: json["description"],
        roofColor: json["roofColor"],
        doorColor: json["doorColor"],
        state: json["state"],
        pincode: json["pincode"],
      );

  Map<String, dynamic> toJson() => {
        "line1": line1,
        "line2": line2,
        "description": description,
        "roofColor": roofColor,
        "doorColor": doorColor,
        "state": state,
        "pincode": pincode,
      };
}

class AdressEditingController {
  final TextEditingController line1;
  final TextEditingController line2;
  final TextEditingController state;
  final TextEditingController pincode;
  final TextEditingController description;
  final TextEditingController roofColor;
  final TextEditingController doorColor;

  AdressEditingController({
    required this.line1,
    required this.line2,
    required this.state,
    required this.pincode,
    required this.description,
    required this.roofColor,
    required this.doorColor,
  });

  Address get address => Address(
        line1: line1.text,
        line2: line2.text,
        description: description.text,
        roofColor: roofColor.text,
        doorColor: doorColor.text,
        state: state.text,
        pincode: pincode.text,
      );
}
