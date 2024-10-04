import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomOtpInput extends StatelessWidget {
  final VoidCallback onClose;

  const CustomOtpInput({super.key, required this.onClose});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent, // Make the dialog background transparent
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
                onPressed: onClose, // Close the modal
              ),
            ),
            // Title "Verification Code"
            Text(
              "Verification Code",
              style: GoogleFonts.poppins(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
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
              showFieldAsBox: true,
              onCodeChanged: (String code) {
                //handle validation or checks here
              },
              focusedBorderColor: const Color.fromARGB(255, 175, 175, 175),
              borderWidth: 2.0,
              fieldWidth: 45.0,
              fieldHeight: 45.0,
              onSubmit: (String verificationCode) {
                // Handle code submission
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: onClose, // Close the modal after verification
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
