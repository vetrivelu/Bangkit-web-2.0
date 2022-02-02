import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

MyFeedback feedbackFromJson(String str) => MyFeedback.fromJson(json.decode(str));

String feedbackToJson(MyFeedback data) => json.encode(data.toJson());

CollectionReference feedback = FirebaseFirestore.instance.collection('Feedback');

class MyFeedback {
  MyFeedback(
      {this.uid,
      required this.title,
      required this.description,
      required this.raiseddDate,
      required this.starRatings,
      this.raisedBy = '',
      this.icNumber = ''});

  String? uid;
  String title;
  String description;
  DateTime raiseddDate;
  String? raisedBy;
  String? icNumber;
  int starRatings;

  factory MyFeedback.fromJson(Map<String, dynamic> json) => MyFeedback(
        uid: json["uid"],
        title: json["title"],
        description: json["description"],
        raiseddDate: json["raiseddDate"].toDate(),
        starRatings: json["starRatings"],
        icNumber: json["IC number"],
        raisedBy: json["Raised By"],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "title": title,
        "description": description,
        "raiseddDate": raiseddDate,
        "starRatings": starRatings,
      };

  Future<void> addFeedback() async {
    // Call the user's CollectionReference to add a new user
    return feedback.doc(uid).set(toJson()).then((value) => print("Feedback Added")).catchError((error) => "Failed to add user: $error");
  }

  Future<void> deleteFeedback() {
    return feedback.doc(uid).delete().then((value) => print("Feedback Deleted")).catchError((error) => print("Failed to delete Feedback: $error"));
  }
}
