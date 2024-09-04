import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Header extends StatelessWidget {
  final String? title; // Title is optional

  const Header({
    super.key,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black,size: 30,),
          onPressed: () {
            Get.back(); // Navigate to the previous screen
          },
        ),
        if (title != null) // If title is provided, display it
          Text(
            title!,
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
      ],
    );
  }
}
