import 'package:get/get.dart';

class LoginController extends GetxController {
  var rememberMe = false.obs;

  void toggleRememberMe() {
    rememberMe.value = !rememberMe.value;
  }
}