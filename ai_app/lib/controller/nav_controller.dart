import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavController extends GetxController {
  final PageController pageController = PageController();
  var tabIndex = 0.obs;
}
