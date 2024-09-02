import 'package:demo_app/presentation/routes/app_routes.dart';
import 'package:demo_app/presentation/screens/login_screen.dart';
import 'package:demo_app/presentation/screens/splash_screen.dart';
import 'package:get/get.dart';

class AppPages {
  static final routes = [
    GetPage(name: AppRoutes.splash, page: () => SplashScreen()),
    GetPage(name: AppRoutes.login, page: () => LoginScreen()),
  ];
}