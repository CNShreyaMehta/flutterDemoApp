import 'package:demo_app/presentation/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/login_controller.dart';

class LoginScreen extends StatelessWidget {
  final LoginController controller = Get.put(LoginController());

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 50),
              Text(
                "Login in Your",
                style: Theme.of(context).textTheme.displayLarge,
              ),
              const SizedBox(height: 5),
              Text(
                "Account",
                style: Theme.of(context).textTheme.displayLarge,
              ),
              const SizedBox(height: 20),
              _buildTextField("Email*", "example@site.com"),
              _buildPasswordField("Password*", "enter password"),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(
                    () => Row(
                      children: [
                        Checkbox(
                          value: controller.rememberMe.value,
                          onChanged: (value) {
                            controller.toggleRememberMe();
                          },
                        ),
                        const Text("Remember me"),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Get.offNamed(AppRoutes.forgotPassword);
                    },
                    child: const Text("Forgot password?"),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Login"),
                    SizedBox(width: 10),
                    Icon(Icons.arrow_forward),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Center(
                child: Text("Or login with"),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: Image.asset('assets/images/google.png',
                      width: 30, height: 30),
                  label: const Text("Google"),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    side: const BorderSide(color: Colors.black),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don’t have an account yet? "),
                    TextButton(
                      onPressed: () {
                        Get.offNamed(AppRoutes.signup);
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.black,
                        textStyle: const TextStyle(
                          fontSize: 16, // Font size
                          fontWeight: FontWeight.bold, // Font weight
                        ),
                      ),
                      child: const Text("Signup"),
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
        const SizedBox(height: 10),
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
}
