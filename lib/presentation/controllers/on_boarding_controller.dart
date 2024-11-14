import 'package:demo_app/presentation/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoardingController extends GetxController {
  static OnBoardingController get instance => Get.find();

  // OnBoardingController instance
  final pageController = PageController();
  Rx<int> currentIndex = 0.obs;
  static const String onboardingKey = 'isOnboardingComplete';

  // update current index when page scroll 
  void updateCurrentIndex(int index) {
    currentIndex.value = index;
  }

  //jump to spacifec dot selected page
  void dotNavigationClicked(int index) {
  currentIndex.value = index;
  pageController.jumpToPage(index);
  }
  

  void nextPage() {
    if (currentIndex.value == 2) {
      Get.offNamed(AppRoutes.gamesHome);
    }
  }

  void skipPage() {
    Get.offNamed(AppRoutes.gamesHome);
    currentIndex.value = 2;
    pageController.jumpToPage(2);
  }

  
// Method to check if onboarding is complete
  Future<bool> isOnboardingComplete() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(onboardingKey) ?? false;
  }

  // Method to set onboarding as complete
  Future<void> completeOnboarding() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(onboardingKey, true);
    print('Onboarding complete');
    Get.offNamed(AppRoutes.gamesHome); // Navigate to Home Screen and clear previous routes
  }
    Future<void> aboutCompleteOnboarding() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(onboardingKey, false);
    print('aboutCompleteOnboarding false complete  >>> ');
    Get.offNamed(AppRoutes.onboarding); // Navigate to Home Screen and clear previous routes
  }
}