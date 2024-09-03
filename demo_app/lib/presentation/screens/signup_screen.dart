import 'package:demo_app/presentation/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/signup_controller.dart';

class SignupScreen extends StatelessWidget {
  final SignupController controller = Get.put(SignupController());

  SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              Text(
                "Create a New Account",
                style: Theme.of(context).textTheme.displayLarge,
                // GoogleFonts.poppins(
                //   fontSize: 24,
                //   fontWeight: FontWeight.bold,
                // ),
                
              ),
              const SizedBox(height: 20),
              _buildTextField("First Name*", "Type first name"),
              _buildTextField("Last Name*", "Type last name"),
              const SizedBox(height: 10),
              Text(
                "Gender",
                style: GoogleFonts.poppins(fontSize: 16),
              ),
              Row(
                children: [
                  Obx(
                    () => Radio<String>(
                      value: "Male",
                      groupValue: controller.gender.value,
                      onChanged: (value) {
                        controller.setGender(value!);
                      },
                    ),
                  ),
                  const Text("Male"),
                  Obx(
                    () => Radio<String>(
                      value: "Female",
                      groupValue: controller.gender.value,
                      onChanged: (value) {
                        controller.setGender(value!);
                      },
                    ),
                  ),
                  const Text("Female"),
                ],
              ),
              const SizedBox(height: 10),
              _buildDateField(context, "DOB", "Choose date of birth"),
              _buildTextField("Email*", "example@site.com"),
              _buildPasswordField("Choose Password*", "Minimum 8 characters"),
              _buildPasswordField("Confirm Password*", "Minimum 8 characters"),
              _buildTextField("Home Course", "Type home course name"),
              _buildDropdown("Country", ["India", "USA", "UK"],
                  controller.selectedCountry),
              _buildDropdown("City", ["Mumbai", "New York", "London"],
                  controller.selectedCity),
              Row(
                children: [
                  Checkbox(
                    value: true,
                    onChanged: (value) {},
                  ),
                  const Text("Yes, I agree to the"),
                  TextButton(
                    onPressed: () {},
                    child: const Text("terms & service."),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Get.offNamed(AppRoutes.otpVerification);
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Sign Up"),
                    SizedBox(width: 10),
                    Icon(Icons.arrow_forward),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Center(
                child: Text("Or sign up with"),
              ),
              const SizedBox(height: 10),
              OutlinedButton.icon(
                onPressed: () {},
                icon: Image.network(
                  'https://upload.wikimedia.org/wikipedia/commons/thumb/5/53/Google_%22G%22_Logo.svg/512px-Google_%22G%22_Logo.svg.png',
                  height: 24,
                  width: 24,
                ),
                label: const Text("Google"),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  side: const BorderSide(color: Colors.black),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an account? "),
                    TextButton(
                      onPressed: () {
                        Get.offNamed(AppRoutes.login);
                      },
                      child: const Text("Login"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, String hint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(fontSize: 16),
        ),
        TextField(
          decoration: InputDecoration(
            hintText: hint,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  Widget _buildPasswordField(String label, String hint) {
    return _buildTextField(label, hint);
  }

  Widget _buildDateField(BuildContext context, String label, String hint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(fontSize: 16),
        ),
        TextField(
          readOnly: true,
          decoration: InputDecoration(
            hintText: hint,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            suffixIcon: const Icon(Icons.calendar_today_outlined),
          ),
          onTap: () {
            showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(1900),
              lastDate: DateTime(2100),
            );
          },
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  Widget _buildDropdown(
      String label, List<String> items, RxString selectedItem) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(fontSize: 16),
        ),
        Obx(
          () => DropdownButton<String>(
            isExpanded: true,
            value: selectedItem.value.isEmpty ? null : selectedItem.value,
            hint: Text("Select $label"),
            items: items.map((String item) {
              return DropdownMenuItem<String>(
                value: item,
                child: Text(item),
              );
            }).toList(),
            onChanged: (value) {
              selectedItem.value = value!;
            },
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
