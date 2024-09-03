import 'package:get/get.dart';

class OTPController extends GetxController {
  var otpCode = ''.obs;

  void updateOTP(String code) {
    otpCode.value = code;
  }
}