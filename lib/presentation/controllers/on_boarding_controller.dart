import 'package:demo_app/presentation/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class variables extends GetxController {
  static variables get instance => Get.find();

  @override
  void onInit() {
    super.onInit();
    //navigateToLogin();
  }
  // variables
  final pageController = PageController();
  Rx<int> currentIndex = 0.obs;

  // update current index when page scroll 
  void updateCurrentIndex(int index) {
    currentIndex.value = index;
  }

  //jump to spacifec dot selected page
  void jumpToPage(int index) {
  currentIndex.value = index;
  pageController.jumpToPage(index);
  }
  

  void navigateToLogin() {
    Get.offNamed(AppRoutes.sudoku);
  }
}