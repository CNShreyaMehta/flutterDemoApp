import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TDeviceUtility {

  static double getScreenheight() {
    return MediaQuery.of(Get.context!).size.height;
  }

  static double getScreenwidth() {
    return MediaQuery.of(Get.context!).size.width;
  }

  static double getDevicePixelRatio() {
    return MediaQuery.of(Get.context!).devicePixelRatio;
  }

  static double getStatusBarHeight() {
    return MediaQuery.of(Get.context!).padding.top;
  }

  static double getBottomBarHeight() {
    return MediaQuery.of(Get.context!).padding.bottom;
  }
  
}