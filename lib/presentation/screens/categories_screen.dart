import 'package:demo_app/presentation/custom_widgets/custom_text_button.dart';
import 'package:demo_app/presentation/routes/app_routes.dart';
import 'package:demo_app/presentation/screens/profile_screen.dart';
import 'package:demo_app/presentation/screens/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}
final List<Widget> _Categoryscreens = [
  const CategoriesScreen(),
  const ProfileScreen(),
  const SettingsScreen(),
];
class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Categories'),
        ),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Categories Screen'),
            CustomTextButton(
              onPressed: () {
                Get.offNamed(AppRoutes.profile);
              },
              text: "Sign-up",
              textStyle:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              foregroundColor: Colors.black, // Custom text color
            ),
          ],
        )));
  }
}
