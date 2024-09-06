import 'package:demo_app/presentation/routes/app_routes.dart';
import 'package:demo_app/presentation/widgets/custom_elevated_button.dart';
import 'package:demo_app/presentation/widgets/custom_outlined_button.dart';
import 'package:demo_app/presentation/widgets/custom_text_button.dart';
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
                Obx(() => TextInput(
                      label: "Email*",
                      hint: "example@site.com",
                      controller: controller.emailController,
                      obscureText: false,
                      onTogglePassword: () {}, // Not required for email
                      errorText: controller.emailError.value.isNotEmpty
                          ? controller.emailError.value
                          : null, // Display error if exists
                    )),
                // _buildTextField("Password*", "enter password",
                //     controller.passwordController, true),
                Obx(() => TextInput(
                      label: "Password*",
                      hint: "enter password",
                      controller: controller.passwordController,
                      isPassword: true,
                      obscureText: _obscurePassword,
                      errorText: controller.passwordError.value.isNotEmpty
                          ? controller.passwordError.value
                          : null,
                      onTogglePassword: () {
                        setState(() {
                          _obscurePassword =
                              !_obscurePassword; // Toggle password visibility
                        });
                      },
                    )),
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
                // Use the custom button
                CustomElevatedButton(
                  onPressed: () async {
                    await controller.validateAndLogin();
                    await LoginController().login(
                        controller.emailController.text,
                        controller.passwordController.text);
                  },
                  text: "Login",
                  icon: Icons.arrow_forward,
                ),
                const SizedBox(height: 20),
                const Center(
                  child: Text("Or login with"),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: CustomOutlinedButton(
                    onPressed: () {},
                    icon: Image.asset('assets/images/google.png',
                        width: 30, height: 30),
                    label: "Google", // Button label
                    borderSide: const BorderSide(color: Colors.black),
                    labelColor: Colors.black, // Label color
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don’t have an account yet? "),
                      CustomTextButton(
                        onPressed: () {
                          Get.offNamed(AppRoutes.signup);
                        },
                        text: "Sign-up",
                        textStyle: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                        foregroundColor: Colors.black, // Custom text color
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
