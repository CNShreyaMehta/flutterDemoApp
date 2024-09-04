import 'package:demo_app/presentation/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
    // Observable fields to track if Remember Me is checked
  var rememberMe = false.obs;
  var isPasswordVisible = false.obs; // Password visibility toggle
// Text controllers for email and password fields
  final emailController = TextEditingController();
  final passwordController = TextEditingController();



  // Validate email and password
  void validateAndLogin() {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      Fluttertoast.showToast(msg: "Please fill all the fields");
    } else if (!GetUtils.isEmail(email)) {
      Fluttertoast.showToast(msg: "Please enter a valid email");
    } else if (password.length < 8) {
      Fluttertoast.showToast(msg: "Password must be at least 8 characters");
    } else {
      Fluttertoast.showToast(msg: "Login successful");
      // Proceed with login (e.g., API call or navigation)
      Get.offNamed(AppRoutes.signup);
    }
  }
  void toggleRememberMe() {
    rememberMe.value = !rememberMe.value;
  }
   // Toggle password visibility
  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }
}