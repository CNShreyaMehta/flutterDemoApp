import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController {
  // Track the current theme mode
  var isDarkMode = false.obs;

  // Function to toggle theme mode
  void toggleTheme() {
    if (Get.isDarkMode) {
      Get.changeThemeMode(ThemeMode.light);
      isDarkMode.value = false;
    } else {
      Get.changeThemeMode(ThemeMode.dark);
      isDarkMode.value = true;
    }
  }
}
