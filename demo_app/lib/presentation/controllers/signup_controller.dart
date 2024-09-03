import 'package:get/get.dart';

class SignupController extends GetxController {
  var gender = "".obs;
  var selectedCountry = "".obs;
  var selectedCity = "".obs;

  void setGender(String value) {
    gender.value = value;
  }

  void setSelectedCountry(String value) {
    selectedCountry.value = value;
  }

  void setSelectedCity(String value) {
    selectedCity.value = value;
  }
}