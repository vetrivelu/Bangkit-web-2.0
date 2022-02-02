// To parse this JSON data, do
//
//     final volunteer = volunteerFromJson(jsonString);

import 'dart:convert';

Volunteer volunteerFromJson(String str) => Volunteer.fromJson(json.decode(str));

String volunteerToJson(Volunteer data) => json.encode(data.toJson());

class Volunteer {
  Volunteer({
    this.uid,
    required this.name,
    required this.phone,
    required this.icNumber,
    required this.email,
    required this.address,
    required this.pincode,
    required this.state,
    required this.attachments,
    required this.isApproved,
  });

  String? uid;
  String name;
  String phone;
  String icNumber;
  String email;
  String address;
  String pincode;
  String state;
  List<String> attachments;
  bool isApproved;

  factory Volunteer.fromJson(Map<String, dynamic> json) => Volunteer(
        uid: json["uid"],
        name: json["name"],
        phone: json["phone"],
        icNumber: json["icNumber"],
        email: json["email"],
        address: json["address"],
        pincode: json["pincode"],
        state: json["state"],
        attachments: List<String>.from(json["attachments"].map((x) => x)),
        isApproved: json["isApproved"],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "name": name,
        "phone": phone,
        "icNumber": icNumber,
        "email": email,
        "address": address,
        "pincode": pincode,
        "state": state,
        "attachments": List<dynamic>.from(attachments.map((x) => x)),
        "isApproved": isApproved,
      };
}
