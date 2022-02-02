import 'package:bangkit/services/firebase.dart';

class Adun {
  Adun({
    this.id,
    required this.name,
    required this.image,
    required this.state,
    required this.contactNumber,
    required this.officeAddress,
    required this.postCode,
    required this.emailAddress,
    required this.description,
    required this.weburl,
    required this.federal,
  });

  int? id;
  String name;
  String state;
  String contactNumber;
  String officeAddress;
  String postCode;
  String emailAddress;
  String description;
  String image;
  String weburl;
  String federal;

  factory Adun.fromJson(Map<String, dynamic> json) => Adun(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        state: json["state"],
        contactNumber: json["contactNumber"],
        officeAddress: json["officeAddress"],
        postCode: json["postCode"],
        emailAddress: json["emailAddress"],
        description: json["description"],
        weburl: json['weburl'],
        federal: json["federal"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "state": state,
        "contactNumber": contactNumber,
        "officeAddress": officeAddress,
        "postCode": postCode,
        "emailAddress": emailAddress,
        "description": description,
        "searchString": searchString,
        "weburl": weburl,
        "federal": federal,
      };
  static Future<dynamic> addAdun(Adun adun) async {
    return firestore.runTransaction((transaction) async {
      DocumentSnapshot snapshot = await transaction.get(counters);
      if (snapshot.exists) {
        var data = snapshot.data() as Map<String, dynamic>;
        adun.id = data['aduns'] + 1;
        return transaction.update(counters, {"aduns": adun.id}).set(aduns.doc(adun.id.toString()), adun.toJson());
      }
    }).then((value) {
      return {"code": "Success", "message": "Added"};
    }).catchError((error) {
      return {"code": "Failed", "message": error.toString()};
    });
  }

  delete() {
    return aduns.doc(id.toString()).delete();
  }

  update() {
    return aduns.doc(id.toString()).update(toJson());
  }

  static list(String? postCode) {
    Query query = ngos;
    if (postCode != null) {
      query = query.where("postCode", isEqualTo: postCode);
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

  makeSearchArray() {}
}
