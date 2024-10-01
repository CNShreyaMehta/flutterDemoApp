import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/base_controller.dart';

class BaseView extends GetView<BaseController> {
  const BaseView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() =>
          controller.widgetOptions.elementAt(controller.selectedIndex.value)),
      bottomNavigationBar: 
        CurvedNavigationBar(
        //key: _bottomNavigationKey,
        index: 0,
        items: const <Widget>[
          Icon(Icons.home, size: 30),
          Icon(Icons.category, size: 30),
          Icon(Icons.shopping_cart, size: 30),
          Icon(Icons.person, size: 30),
          Icon(Icons.get_app_rounded, size: 30),
        ],
        color: Colors.yellow.shade300,
        buttonBackgroundColor: Colors.yellow.shade700,
        backgroundColor: const Color.fromARGB(0, 0, 0, 0),
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 600),
        onTap: controller.onItemTapped,
        letIndexChange: (index) => true,
      ),
    );
  }
}
