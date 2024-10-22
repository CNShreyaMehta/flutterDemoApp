import 'package:demo_app/presentation/controllers/login_controller.dart';
import 'package:demo_app/presentation/routes/app_pages.dart';
import 'package:demo_app/presentation/screens/home_screen.dart';
import 'package:demo_app/presentation/screens/splash_screen.dart';
import 'package:demo_app/presentation/utils/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final LoginController authController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Example App',
      initialRoute: AppPages.beforeAuthentication,
      getPages: AppPages.routes,
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: FutureBuilder(
        future: authController.checkAuthToken(), // Check token on app startup
        builder: (context, snapshot) {
          // Show a loading indicator while token is being checked
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          // If logged in, show Home screen, otherwise show Login screen
          return Obx(() => authController.isLoggedIn.value
              ? const HomeScreen()
              :  SplashScreen());  //LoginScreen()
        },
      ),
    );
  }
}