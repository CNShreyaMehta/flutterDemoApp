import 'package:demo_app/presentation/routes/navigation_ids.dart';
import 'package:get/get.dart';

class SettingController extends GetxController {
  void goBack() {
    // id is necessary to go back to previous nested route
    Get.back(id: nestedNavigationProfileId);
  }
}

