import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
    // Observable fields to track if Remember Me is checked
  var rememberMe = false.obs;
  var isPasswordVisible = false.obs; // Password visibility toggle
// Text controllers for email and password fields
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  var isLoggedIn = false.obs; // Observable to track login status
  final storage = GetStorage(); // Local storage using GetStorage

 @override
  void onInit() {
    super.onInit();
    checkAuthToken(); // Check if the token exists when the app starts
  }

  // Validate email and password
  Future<void> validateAndLogin() async {
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
     // Get.offNamed(AppRoutes.signup);
    }
  }
  void toggleRememberMe() {
    rememberMe.value = !rememberMe.value;
  }
   // Toggle password visibility
  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  // Simulate an API call that generates a random token
  Future<void> login(String username, String password) async {
    await Future.delayed(const Duration(seconds: 2)); // Simulate network delay

    // Generate a random token
    String token = _generateRandomToken();

    // Store the token in local storage
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);

    // Update the login status
    isLoggedIn.value = true;
  }

  // Generate a random token (simulating an API response)
  String _generateRandomToken() {
    const chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    Random random = Random();
    return String.fromCharCodes(Iterable.generate(16, (_) => chars.codeUnitAt(random.nextInt(chars.length))));
  }

  // Check if a token exists in local storage
  Future<void> checkAuthToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth_token');

    if (token != null) {
      isLoggedIn.value = true; // Token found, user is logged in
    } else {
      isLoggedIn.value = false; // No token, user is not logged in
    }
  }

  // Log out by removing the token from local storage
  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token'); // Remove token

    isLoggedIn.value = false; // Update login status
  }

}