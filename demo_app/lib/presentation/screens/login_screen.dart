import 'package:demo_app/presentation/routes/app_routes.dart';
import 'package:demo_app/presentation/widgets/text_Input.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/login_controller.dart';

// ignore: must_be_immutable
class LoginScreen extends StatefulWidget {

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LoginController controller = Get.put(LoginController());

bool _obscurePassword = true; 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                // _buildTextField("Email*", "example@site.com",
                //     controller.emailController, false),
                     TextInput(
                  label: "Email*",
                  hint: "example@site.com",
                  controller: controller.emailController,
                  obscureText: false,
                  onTogglePassword: () {}, // Not required for email
                ),
                // _buildTextField("Password*", "enter password",
                //     controller.passwordController, true),
                TextInput(
                  label: "Password*",
                  hint: "enter password",
                  controller: controller.passwordController,
                  isPassword: true,
                  obscureText: _obscurePassword,
                  onTogglePassword: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword; // Toggle password visibility
                    });
                  },
                ),
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
                            activeColor: Colors
                                .black, // Changes the color when the checkbox is active (checked)
                            checkColor: Colors
                                .white, // Changes the color of the checkmark inside the box
                          ),
                          const Text("Remember me"),
                        ],
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.offNamed(AppRoutes.forgotPassword);
                      },
                      child: Text(
                        "Forgot password?",
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    controller.validateAndLogin();
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
                const SizedBox(height: 20),
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
                        child: const Text("Sign-up"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
