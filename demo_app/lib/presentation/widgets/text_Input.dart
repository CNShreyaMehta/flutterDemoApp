// ignore: file_names
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextInput extends StatelessWidget {
  final String label;
  final String hint;
  final TextEditingController controller;
  final bool isPassword;
  final bool obscureText;
  final VoidCallback onTogglePassword;

  const TextInput({
    super.key,
    required this.label,
    required this.hint,
    required this.controller,
    this.isPassword = false,
    this.obscureText = true,
    required this.onTogglePassword,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(fontSize: 16,color: Colors.black),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: controller,
          obscureText: isPassword ? obscureText : false, // Control password visibility
          decoration: InputDecoration(
            hintText: hint,
            suffixIcon: isPassword
                ? IconButton(
                    icon: Icon(obscureText ? Icons.visibility_off : Icons.visibility),
                    onPressed: onTogglePassword, // Handle password visibility toggle
                  )
                : null,
            contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
