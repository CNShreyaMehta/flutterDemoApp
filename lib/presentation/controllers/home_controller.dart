import 'package:demo_app/presentation/routes/app_routes.dart';
import 'package:demo_app/presentation/screens/product_tile.dart';
import 'package:demo_app/presentation/services/remote_services.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  // You can add any logic or state management here if needed
  final emailController = TextEditingController();
   var isLoading = true.obs;
  var productList = List<Product>.empty().obs;
    var currentIndex = 0.obs;
     // Observable variable
  var counter = 0.0.obs;
  var counter2 = 0.0.obs;


void changeTabIndex(int index) {
    currentIndex.value = index;
  }
 @override
  void onInit() {
    fetchProducts();
    super.onInit();
  }
    // Method to increment
  void increment() => {
    counter.value = counter.value + 0.1,
    if (counter.value >= 0.9) {
      print("MAX REACHED"),
      counter2.value = 1.0
    }
  } ;

  // Method to decrement
  void decrement() {
    if (counter > 0) {
      counter.value = counter.value - 0.1; // Prevent going below 0
      counter2.value = 0.0;
    }
  }
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

    void fetchProducts() async {
    try {
      isLoading(true);
      var products = await RemoteServices.fetchProducts();
      if (products != null) {
        productList.value = products;
      }
    } finally {
      isLoading(false);
    }
  }
}
