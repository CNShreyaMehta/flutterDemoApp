import 'dart:io';

import 'package:demo_app/presentation/custom_widgets/custom_autocomplete.dart';
import 'package:demo_app/presentation/custom_widgets/custom_date_picker.dart';
import 'package:demo_app/presentation/custom_widgets/custom_image_picker.dart';
import 'package:demo_app/presentation/custom_widgets/custom_otp_Input.dart';
import 'package:demo_app/presentation/custom_widgets/custom_spinner.dart';
import 'package:demo_app/presentation/custom_widgets/dropdown.dart';
import 'package:demo_app/presentation/custom_widgets/header.dart';
import 'package:demo_app/presentation/custom_widgets/text_input.dart';
import 'package:demo_app/presentation/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controllers/signup_controller.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool _isLoading = false;

  void _simulateLoading() {
    setState(() {
      _isLoading = true;
    });

    // Simulate a delay for loading
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  final SignupController controller = Get.put(SignupController());
// Controller to hold the selected date
  final TextEditingController _dateController = TextEditingController();
  final Uri termsUrl = Uri.parse('https://login.stage-callsteward.com/#/login');

  Future<void> _launchURL() async {
    // ignore: avoid_print
    print('Launching $termsUrl');
    if (!await launchUrl(termsUrl)) {
      throw 'Could not launch $termsUrl';
    }
  }

  @override
  void dispose() {
    _dateController
        .dispose(); // Dispose the controller when the widget is disposed
    super.dispose();
  }

 File? _image;

  void _handleImageSelected(File image) {
    setState(() {
      _image = image;
    });
  }


  final List<String> countries = [
    'India',
    'United States',
    'Germany',
    'Australia',
    'Canada',
    'United Kingdom',
  ];

  String selectedCountry = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header with optional title
                    const Header(
                        //title: "Login in Your Account",
                        //backgroundColor: Colors.blueAccent,
                        //showBellIcon: true, // Show the bell icon in this screen
                        ),
                    Text(
                      "Create a New",
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "Account",
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                     CustomImagePicker(
              onImageSelected: _handleImageSelected, // Handle image selection
            ),
            const SizedBox(height: 20),
            if (_image != null)
              Text(
                'Selected Image Path: ${_image!.path}',
                style: const TextStyle(fontSize: 16),
              )
            else
              const Text('No image selected yet.'),
                    const SizedBox(height: 40),
                    TextInput(
                      label: "First Name*",
                      hint: "first name",
                      controller: controller.firstNameController,
                      obscureText: false,
                      onTogglePassword: () {}, // Not required for email
                    ),
                    TextInput(
                      label: "Last Name*",
                      hint: "last name",
                      controller: controller.lastNameController,
                      obscureText: false,
                      onTogglePassword: () {}, // Not required for email
                    ),
                    const SizedBox(height: 15),
                    CustomAutocomplete<String>(
                      options: countries,
                      displayStringForOption: (String option) => option,
                      onSelected: (String selection) {
                        setState(() {
                          selectedCountry = selection;
                        });
                      },
                      labelText: 'Select Country',
                    ),
                    const SizedBox(height: 20),
                    Text('Selected Country: $selectedCountry'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Gender",
                          style: GoogleFonts.poppins(
                              fontSize: 16, color: Colors.black),
                        ),
                        Row(children: [
                          Obx(
                            () => Radio<String>(
                              value: "Male",
                              groupValue: controller.gender.value,
                              onChanged: (value) {
                                controller.setGender(value!);
                              },
                              activeColor: Colors.black,
                            ),
                          ),
                          Text(
                            "Male",
                            style: GoogleFonts.poppins(
                                fontSize: 16, color: Colors.black),
                          ),
                          Obx(
                            () => Radio<String>(
                              value: "Female",
                              groupValue: controller.gender.value,
                              onChanged: (value) {
                                controller.setGender(value!);
                              },
                              activeColor: Colors.black,
                            ),
                          ),
                          Text(
                            "Female",
                            style: GoogleFonts.poppins(
                                fontSize: 16, color: Colors.black),
                          ),
                        ])
                      ],
                    ),
                    const SizedBox(height: 0),
                    //_buildDateField(context, "DOB", "Choose date of birth"),
                    CustomDatePicker(
                      controller: _dateController,
                      label: "DOB",
                      hint: "Choose date of birth",
                    ),
                    TextInput(
                      label: "Email*",
                      hint: "example@site.com",
                      controller: controller.emailController,
                      obscureText: false,
                      onTogglePassword: () {}, // Not required for email
                    ),
                    TextInput(
                      label: "Choose Password*",
                      hint: "Minimum 8 characters",
                      controller: controller.passwordController,
                      obscureText: false,
                      onTogglePassword: () {}, // Not required for email
                    ),
                    TextInput(
                      label: "Confirm Password*",
                      hint: "Minimum 8 characters",
                      controller: controller.confirmPasswordController,
                      obscureText: false,
                      onTogglePassword: () {}, // Not required for email
                    ),
                    Dropdown(
                      label: "Country",
                      items: const ["USA", "India", "UK"],
                      selectedItem: controller.selectedCountry,
                    ),
                    Dropdown(
                      label: "City",
                      items: const ["Mumbai", "New York", "London"],
                      selectedItem: controller.selectedCity,
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: controller.rememberMeSignup.value,
                          onChanged: (value) {
                            controller.toggleRememberMeSignup();
                          },
                          activeColor: Colors.black,
                          checkColor: Colors.white,
                        ),
                        const Text("Yes, I agree to the"),
                        TextButton(
                          onPressed: () {
                            _launchURL();
                          },
                          child: Text(
                            "terms & service.",
                            style: Theme.of(context).textTheme.displaySmall,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        controller.validateAndSignup();
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            return CustomOtpInput(onClose: () {
                              Navigator.of(context).pop(); // Close the dialog
                            });
                          },
                        );
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
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        onPressed: _simulateLoading,
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
                          const Text("Already have an account? "),
                          TextButton(
                            onPressed: () {
                              Get.offNamed(AppRoutes.login);
                            },
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.black,
                              textStyle: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            child: const Text("Login"),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SpinnerWidget(
              isLoading: _isLoading,
              loadingMessage: 'Please wait...',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOTPDialog(BuildContext context) {
    return Dialog(
      backgroundColor:
          Colors.transparent, // Make the dialog background transparent
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Close icon (cross icon)
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: const Icon(
                  Icons.close,
                  size: 35,
                ),
                onPressed: () {
                  Navigator.of(context).pop(); // Close the modal
                },
              ),
            ),
            // Title "Verification Code"
            Text(
              "Verification Code",
              style: GoogleFonts.poppins(
                  fontSize: 22,
                  //fontWeight: FontWeight.w600,
                  color: Colors.black),
            ),
            const SizedBox(height: 10),
            Text(
              "We have sent the verification code to your email id.",
              style: Theme.of(context).textTheme.displayMedium,
            ),
            const SizedBox(height: 10),
            Text(
              "Enter Code",
              style: Theme.of(context).textTheme.displaySmall,
            ),
            const SizedBox(height: 10),
            OtpTextField(
              numberOfFields: 5,
              borderColor: const Color(0xFF512DA8),
              //set to true to show as box or false to show as dash
              showFieldAsBox: true,
              //runs when a code is typed in
              onCodeChanged: (String code) {
                //handle validation or checks here
              },
              //runs when every textfield is filled
              focusedBorderColor: const Color.fromARGB(255, 175, 175, 175),
              //styles: ,
              borderWidth: 2.0,
              fieldWidth: 45.0,
              fieldHeight: 45.0,
              onSubmit: (String verificationCode) {
                // showDialog(
                //     context: context,
                //     builder: (context) {
                //       return AlertDialog(
                //         title: const Text("Verification Code"),
                //         content:
                //             Text('Code entered is $verificationCode'),
                //       );
                //     });
              }, // end onSubmit
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the modal
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Verify and Continue"),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: TextButton(
                onPressed: () {
                  // Implement resend logic
                },
                style: TextButton.styleFrom(
                  foregroundColor: Colors.black,
                  textStyle: const TextStyle(
                    fontSize: 16, // Font size
                    fontWeight: FontWeight.bold, // Font weight
                  ),
                ),
                child: const Text("Didn’t receive Code? Resend"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
