import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

// we cant use GetView<HomeController> because home controller need to call with Get.put or Get.lazyPut.
// These methods are available in HomeBinding but because we use BottomNavigationBar in BaseView, we can't call the binding methods of BottomNavigationBar's pages.
// So, I setup controller in build method of each BottomNavigationBar's pages
class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
Widget build(BuildContext context) {
  // !!!
  final HomeController controller = Get.put(HomeController());
  return Scaffold(
    appBar: AppBar(
      title: const Text('HomeView'),
      centerTitle: true,
    ),
    drawer: Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'Menu',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              // Close the drawer and navigate to Home
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.shopping_cart),
            title: const Text('Product Details'),
            onTap: () {
              // Close the drawer and navigate to Product Details
              Navigator.pop(context);
              controller.goToProductDetailsPage();
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              // Add logic for settings navigation
              Navigator.pop(context);
            },
          ),
        ],
      ),
    ),
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Obx(
            () => Text(controller.count.value.toString()),
          ),
          TextButton(
              onPressed: controller.increment, child: const Text("increment")),
          TextButton(
              onPressed: controller.goToProductDetailsPage,
              child: const Text("go to product details")),
        ],
      ),
    ),
  );
}

}
