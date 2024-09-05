import 'package:demo_app/presentation/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  // You can add any logic or state management here if needed
  final emailController = TextEditingController();

  void validateAndforgotPass() {
    String email = emailController.text.trim();
    if (email.isEmpty) {
      Fluttertoast.showToast(msg: "email field cannot be empty");
    } else if (!GetUtils.isEmail(email)) {
      Fluttertoast.showToast(msg: "Please enter a valid email");
    } else {
      Fluttertoast.showToast(msg: "Password reset email sent");
      // Proceed with login (e.g., API call or navigation)
      Get.offNamed(AppRoutes.login);
    }
  }
}
