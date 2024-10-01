import 'package:demo_app/presentation/routes/app_routes.dart';
import 'package:demo_app/presentation/routes/navigation_ids.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void goToProductDetailsPage() {
    // id is necessary for nested routing, id must be and number same as key of Navigator in ProfileWrapper
    Get.toNamed(AppRoutes.productDetails, id: nestedNavigationHomeId);
  }

  void increment() => count.value++;
}
