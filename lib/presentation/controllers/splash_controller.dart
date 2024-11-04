import 'package:demo_app/presentation/controllers/on_boarding_controller.dart';
import 'package:demo_app/presentation/routes/app_routes.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  final OnBoardingController onboardingController =
      Get.put(OnBoardingController());
// Check if onboarding is complete and set initial route accordingly
  @override
  void onInit() async {
    super.onInit();
    bool isComplete = await onboardingController.isOnboardingComplete();
    print(' >>>>> ????? $isComplete');
    isComplete ? navigateToGameHome() : navigateToOnBoarding();
  }

  void navigateToOnBoarding() async {
    await Future.delayed(const Duration(seconds: 4));
    Get.offNamed(AppRoutes.onboarding);
  }

  void navigateToGameHome() async {
    await Future.delayed(const Duration(seconds: 4));
    Get.offNamed(AppRoutes.gamesHome);
  }
}
