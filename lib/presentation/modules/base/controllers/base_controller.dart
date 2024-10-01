import 'package:demo_app/presentation/modules/base/views/profile_wrapper.dart';
import 'package:demo_app/presentation/modules/home/views/home_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BaseController extends GetxController {
  RxInt selectedIndex = 0.obs;
  late List<Widget> widgetOptions;

  BaseController() {
    widgetOptions = <Widget>[
      const HomeWrapper(),
      // this wrapper allow us to nested routes inside it
      const ProfileWrapper(),
    ];
  }

  void onItemTapped(int index) {
    selectedIndex.value = index;
  }
}
