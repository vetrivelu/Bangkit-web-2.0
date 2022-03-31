import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LayoutController extends GetxController{
  static LayoutController instance = Get.find();
  final PageController controller = PageController(initialPage: 0);
  int pageIndex = 0;
  int selectedIndex = 0;
}

LayoutController layoutController = LayoutController.instance;