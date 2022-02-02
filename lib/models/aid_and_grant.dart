// To parse this JSON data, do
//
//     final post = postFromJson(jsonString);

import 'dart:convert';

import 'package:bangkit/constants/controller_constants.dart';
import 'package:bangkit/services/firebase.dart';

Post postFromJson(String str) => Post.fromJson(json.decode(str));

String postToJson(Post data) => json.encode(data.toJson());

class Post {
  Post({
    this.id,
    required this.title,
    required this.description,
    this.media,
    this.attachments,
    this.videos,
    required this.name,
    required this.address,
    required this.state,
    required this.pincode,
    required this.phone,
    required this.email,
    this.created,
    this.updated,
    this.ratings,
  });

  int? id;
  String title;
  String description;
  List<String>? media;
  List<String>? attachments;
  List<String>? videos;

  String name;
  String address;
  String state;
  String pincode;
  String phone;
  String email;
  DateTime? created;
  DateTime? updated;
  List<Rating>? ratings;

  int get totalRaters => ratings!.length;
  int get totalRating {
    int result = 0;
    ratings = ratings ?? [];
    for (var element in ratings!) {
      result += element.stars;
    }
    return result;
  }

  factory Post.fromJson(Map<String, dynamic> json) => Post(
      id: json["id"],
      title: json["title"],
      description: json["description"],
      media: List<String>.from((json["media"] ?? []).map((x) => x)),
      attachments: List<String>.from((json["attachments"] ?? []).map((x) => x)),
      videos: List<String>.from((json["videos"] ?? []).map((x) => x)),
      address: json["address"],
      state: json["state"],
      pincode: json["pincode"],
      phone: json["phone"],
      email: json["email"],
      created: json["created"].toDate(),
      updated: json["updated"].toDate(),
      name: json["name"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "media": media != null ? List<dynamic>.from(media!.map((x) => x)) : media,
        "attachments": attachments == null ? [] : List<dynamic>.from(attachments!.map((x) => x)),
        "videos": videos == null ? [] : List<dynamic>.from(videos!.map((x) => x)),
        "name": name,
        "address": address,
        "state": state,
        "pincode": pincode,
        "phone": phone,
        "email": email,
        "ratings": ratings == null ? [] : List<dynamic>.from(ratings!.map((x) => x.toJson())),
        "created": created,
        "updated": updated,
      };

  update() {
    return posts.doc(id.toString()).update(toJson()).then((value) => "success").catchError((onError) => onError.toString());
  }

  static Future<dynamic> addPost(Post post) async {
    post.created = DateTime.now();
    post.updated = DateTime.now();
    print(post.toJson());
    return firestore.runTransaction((transaction) async {
      DocumentSnapshot snapshot = await transaction.get(counters);
      if (snapshot.exists) {
        var data = snapshot.data() as Map<String, dynamic>;
        post.id = (data['posts'] ?? 0) + 1;
        return transaction.update(counters, {"posts": post.id}).set(posts.doc(post.id.toString()), post.toJson());
      }
    }).then((value) {
      return {"code": "Success", "message": "Added"};
    }).catchError((error) {
      return {"code": "Failed", "message": error.toString()};
    });
  }

  deletePost() {
    posts.doc(id.toString()).delete().then((value) => {"code": "success", "message": "deleted"}).catchError((error) {
      return {"code": "success", "message": "$error"};
    });
  }

  loadRatings() async {
    ratings = ratings ?? [];
    await posts.doc(id.toString()).collection("ratings").get().then((value) {
      ratings = value.docs.map((e) => Rating.fromJson(e.data())).toList();
      print(ratings!.length);
    });
  }

  ratePost(int stars) async {
    if (profileController.profile != null && canRate) {
      print("I am inside rate");
      ratings = ratings ?? [];
      var rating = Rating(uid: profileController.profile!.uid!, name: profileController.profile!.name, stars: stars);
      ratings!.add(rating);
      await posts.doc(id.toString()).update({
        "totalRating": FieldValue.increment(stars),
        "totalRaters": FieldValue.increment(1),
      }).then((value) {
        return posts.doc(id.toString()).collection("ratings").add(rating.toJson()).then((value) => {"code": "Failed", "message": "Added"});
      }).catchError((error) {
        // print(error.toString());
        return {"code": "Failed", "message": error.toString()};
      });
    }
  }

  bool get canRate {
    bool result = true;

    if ((ratings ?? []).isNotEmpty) {
      List<dynamic> temp = ratings!.where((element) => element.uid == profileController.profile!.uid).toList();
      result = temp.isEmpty;
    }

    return result;
  }

  int get myRating {
    int result = 0;

    if ((ratings ?? []).isNotEmpty) {
      ratings!.forEach((element) {
        if (element.uid == profileController.profile!.uid) {
          result = element.stars;
        }
      });
    }

    return result;
  }
}

class Rating {
  Rating({
    required this.uid,
    required this.name,
    required this.stars,
  });

  String uid;
  String name;
  int stars;

  factory Rating.fromJson(Map<String, dynamic> json) => Rating(
        uid: json["uid"],
        name: json["name"],
        stars: json["stars"],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "name": name,
        "stars": stars,
      };
}
