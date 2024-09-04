import 'package:demo_app/presentation/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  var gender = "".obs;
  var selectedCountry = "".obs;
  var selectedCity = "".obs;
  var rememberMeSignup = false.obs;
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  void setGender(String value) {
    gender.value = value;
  }

  void setSelectedCountry(String value) {
    selectedCountry.value = value;
  }

  void setSelectedCity(String value) {
    selectedCity.value = value;
  }
   void toggleRememberMeSignup() {
    rememberMeSignup.value = !rememberMeSignup.value;
  }
    // Validate email and password
  void validateAndSignup() {
    String firstName = firstNameController.text.trim();
    String lastName = lastNameController.text.trim();
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();

    
    if (firstName.isEmpty || lastName.isEmpty || email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      Fluttertoast.showToast(msg: "Please fill all the fields");
    } else if (!GetUtils.isEmail(email)) {
      Fluttertoast.showToast(msg: "Please enter a valid email");
    } else if (password.length < 8) {
      Fluttertoast.showToast(msg: "Password must be at least 8 characters");
    }else if (selectedCountry.value.isEmpty) {
      Get.snackbar('Error', 'Please select a country');
    } else if (selectedCity.value.isEmpty) {
      Get.snackbar('Error', 'Please select a city');
    } else if (gender.value.isEmpty) {
      Fluttertoast.showToast(msg: "Please select a gender");
    }else {
      Fluttertoast.showToast(msg: "Login successful");
      // Proceed with login (e.g., API call or navigation)
      Get.offNamed(AppRoutes.otpVerification);
    }
  }
}