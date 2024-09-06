import 'package:demo_app/presentation/routes/app_routes.dart';
import 'package:demo_app/presentation/screens/forgot_password_screen.dart';
import 'package:demo_app/presentation/screens/home_screen.dart';
import 'package:demo_app/presentation/screens/login_screen.dart';
import 'package:demo_app/presentation/screens/otp_verification_screen.dart';
import 'package:demo_app/presentation/screens/signup_screen.dart';
import 'package:demo_app/presentation/screens/splash_screen.dart';
import 'package:get/get.dart';

class AppPages {
  static final routes = [
        // Auth Flow
    GetPage(name: AppRoutes.splash, page: () => SplashScreen()),
    GetPage(name: AppRoutes.login, page: () => const LoginScreen()),
    GetPage(name: AppRoutes.signup, page: () => const SignupScreen()),
    GetPage(name: AppRoutes.forgotPassword, page: () => ForgotPasswordScreen()),
    GetPage(name: AppRoutes.otpVerification, page: () => OtpVerificationScreen()),

        // Main Flow
    GetPage(name: AppRoutes.home, page: () => const HomeScreen()),
  ];
}