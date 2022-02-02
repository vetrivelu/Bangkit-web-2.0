import 'package:bangkit/services/firebase.dart';

class NgoService {
  NgoService({
    required this.name,
  });

  String name;

  factory NgoService.fromJson(Map<String, dynamic> json) => NgoService(
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };

  static Future<dynamic> addService({required String name}) {
    return services.doc(name).set({"name": name}).then((value) => "SUCCESS").catchError((error) => error.toString());
  }

  static getServices() async {
    List<String> servicelist = await services.get().then((value) => value.docs.map((e) => NgoService.fromJson(e.data()).name).toList());
    return servicelist;
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getServicesStream() {
    return services.snapshots();
  }
}
