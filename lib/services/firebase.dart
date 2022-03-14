export 'package:cloud_firestore/cloud_firestore.dart';
export 'package:cloud_functions/cloud_functions.dart';
export 'dart:convert';
export './auth.dart';
import 'dart:typed_data';

import 'package:path/path.dart';

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
// import 'package:path/path.dart';

final databaseRef = FirebaseDatabase.instance.refFromURL("https://bangkit-83a09-default-rtdb.asia-southeast1.firebasedatabase.app");
final FirebaseFunctions functions = FirebaseFunctions.instance;
final FirebaseFirestore firestore = FirebaseFirestore.instance;

final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
final FirebaseStorage storage = FirebaseStorage.instance;

CollectionReference<Map<String, dynamic>> users = firestore.collection('Users');
CollectionReference<Map<String, dynamic>> ngos = firestore.collection('Ngos');
CollectionReference<Map<String, dynamic>> aduns = firestore.collection('Aduns');
CollectionReference<Map<String, dynamic>> posts = firestore.collection('Posts');
CollectionReference<Map<String, dynamic>> rebuilds = firestore.collection('Rebuilds');
CollectionReference<Map<String, dynamic>> services = firestore.collection('Services');
CollectionReference<Map<String, dynamic>> feedbacks = firestore.collection('Feedback');

CollectionReference<Map<String, dynamic>> floodProneAreas = firestore.collection('FloodProneAreas');
CollectionReference<Map<String, dynamic>> retentionPonds = firestore.collection('RetentionPonds');
CollectionReference<Map<String, dynamic>> reservedAreas = firestore.collection('ReservedAreas');
CollectionReference<Map<String, dynamic>> areas = firestore.collection('Areas');

DocumentReference<Map<String, dynamic>> counters = firestore.collection('globalData').doc('counters');
DocumentReference<Map<String, dynamic>> damLinks = firestore.collection('globalData').doc('DamLinks');
DocumentReference<Map<String, dynamic>> markerInfos = firestore.collection('globalData').doc('MarkerInfo');

Future<String> uploadFile(Uint8List file, String name) async {
  var url = await storage.ref("pics").child(name).putData(file).snapshot.ref.getDownloadURL();
  return url;
}
