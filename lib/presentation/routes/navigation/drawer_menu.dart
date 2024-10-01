import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers//login_controller.dart';

class DrawerMenu extends StatelessWidget {
  final LoginController loginController = Get.find();

   DrawerMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Text('Menu'),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              Get.toNamed('/main/home');
            },
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Profile'),
            onTap: () {
              Get.toNamed('/main/profile');
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              Get.toNamed('/main/settings');
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () {
              loginController.logout();
            },
          ),
        ],
      ),
    );
  }
}
