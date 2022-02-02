import 'dart:core';
import 'package:bangkit/services/firebase.dart';

Rebuild rebuildFromJson(String str) => Rebuild.fromJson(json.decode(str));

String rebuildToJson(Rebuild data) => json.encode(data.toJson());

class Rebuild {
  Rebuild({
    this.id,
    required this.name,
    required this.address,
    required this.postCode,
    required this.state,
    required this.phoneNumber,
    required this.email,
    required this.image,
    required this.description,
    required this.contactPersonName,
    this.props,
    this.type,
    this.entityType,
    this.serviceType,
  });
  int? id;
  String name;
  String image;
  String address;
  String contactPersonName;
  String postCode;
  String state;
  String phoneNumber;
  String email;
  String description;
  String? props;
  Type? type;
  EntityType? entityType;
  ServiceType? serviceType;

  factory Rebuild.fromJson(Map<String, dynamic> json) => Rebuild(
        id: json["id"],
        name: json["name"] ?? '',
        address: json["address"] ?? '',
        phoneNumber: json["phoneNumber"] ?? '',
        image: json["image"] ?? '',
        email: json["email"] ?? '',
        description: json["description"] ?? '',
        contactPersonName: json["contactPersonName"] ?? '',
        props: json["props"],
        type: Type.values.elementAt(json["type"] ?? 0),
        entityType: EntityType.values.elementAt(json["entityType"] ?? 0),
        serviceType: ServiceType.values.elementAt(json["serviceType"] ?? 0),
        postCode: json["postCode"] ?? '',
        state: json["state"] ?? '',
      );

  get searchArray {
    var returns = [];
    returns.add(state);
    if (entityType == EntityType.government) {
      returns.add("government");
    }
    if (entityType == EntityType.private) {
      returns.add("private");
    }
    if (serviceType != null) {
      returns.add(serviceType!.index);
    }
    return returns;
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "address": address,
        "phoneNumber": phoneNumber,
        "email": email,
        "state": state,
        "image": image,
        "description": description,
        "contactPersonName": contactPersonName,
        "props": props,
        // "type": type.index ??,
        "entityType": entityType != null ? entityType!.index : null,
        "serviceType": entityType != null ? serviceType!.index : null,
        "modifiedDate": DateTime.now(),
        "postCode": postCode,
        "searchText": searchString,
        "searchArray": searchArray,
      };

  static Future<dynamic> addrebuild(Rebuild rebuild) async {
    return firestore.runTransaction((transaction) async {
      DocumentSnapshot snapshot = await transaction.get(counters);
      if (snapshot.exists) {
        var data = snapshot.data() as Map<String, dynamic>;
        rebuild.id = data['rebuilds'] + 1;
        return transaction.update(counters, {"rebuilds": rebuild.id}).set(rebuilds.doc(rebuild.id.toString()), rebuild.toJson());
      }
    }).then((value) {
      return {"code": "Success", "message": "Added"};
    }).catchError((error) {
      print(error);
      return {"code": "Failed", "message": error.toString()};
    });
  }

  update() {
    return rebuilds.doc(id.toString()).update(toJson()).then((value) => print("sucess"));
  }

  delete() {
    rebuilds.doc(id.toString()).delete().then((value) => {"code": "success", "message": "rebuild has been deleted"}).catchError((error) {
      return {"code": "Failed", "message": error.toString()};
    });
  }

  static list(
      {Type? type,
      String? postCode,
      EntityType? entityType,
      List<ServiceType>? serviceTypes,
      String? searchText,
      List<String>? states,
      Query? query}) {
    query = query ?? rebuilds;
    if (states != null) {
      query = query.where("state", whereIn: states);
      // print(await query.get().then((value) => value.docs.length));
    }
    if (postCode != null) {
      query = query.where("postCode", isEqualTo: postCode);
    }
    if (type != null) {
      query = query.where("type", isEqualTo: type.index);
    }
    if (entityType != null) {
      query = query.where("entityType", isEqualTo: entityType.index);
    }
    if (serviceTypes != null) {
      query = query.where("serviceTypes", arrayContainsAny: serviceTypes.map((e) => e.index).toList());
    }
    if (serviceTypes != null) {
      query = query.where("serviceTypes", arrayContainsAny: serviceTypes.map((e) => e.index).toList());
    }
    if (serviceTypes != null) {
      query = query.where("serviceTypes", arrayContainsAny: serviceTypes.map((e) => e.index).toList());
    }
    return query;
  }

  List<String> get searchString => makeSearchString(name);
  makeSearchString(String text) {
    List<String> returns = [];
    var length = text.length;
    for (int i = 0; i < length; i++) {
      returns.add(text.substring(0, i));
    }
    returns.add(text);
    return returns;
  }
}

class Address {
  Address({
    required this.line1,
    required this.line2,
    required this.state,
    required this.pincode,
  });

  String line1;
  String line2;
  String state;
  String pincode;

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        line1: json["line1"],
        line2: json["line2"],
        state: json["state"],
        pincode: json["pincode"],
      );

  Map<String, dynamic> toJson() => {
        "line1": line1,
        "line2": line2,
        "state": state,
        "pincode": pincode,
      };
}

enum Type { medical, floodReleif }
enum EntityType { government, private }
enum ServiceType { cleaning, food, assistance }
