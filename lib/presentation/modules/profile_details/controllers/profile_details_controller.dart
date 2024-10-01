import 'package:demo_app/presentation/routes/app_routes.dart';
import 'package:demo_app/presentation/routes/navigation_ids.dart';
import 'package:get/get.dart';

class ProfileDetailsController extends GetxController {
  void goToSettingPage() {
    // id is necessary for nested routing, id must be and number same as key of Navigator in ProfileWrapper
    Get.toNamed(AppRoutes.settings, id: nestedNavigationProfileId);
  }
}
