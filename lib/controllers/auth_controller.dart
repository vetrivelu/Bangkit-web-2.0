import 'package:bangkit/models/profile.dart';
import 'package:bangkit/models/service_category.dart';
import 'package:bangkit/services/firebase.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  var auth = Auth();
}

class ProfileController extends GetxController {
  static ProfileController instance = Get.find();
  Profile? profile;
}

class ServiceListController extends GetxController {
  static ServiceListController instance = Get.find();
  List<String>? service = [];

  @override
  onInit() {
    reloadServices();
  }

  reloadServices() async {
    service = await NgoService.getServices();
  }
}
